provider "digitalocean" {
  token = "${var.digitalocean_token}"
}

resource "digitalocean_tag" "exposed_cluster_machine" {
  name = "exposed_cluster_machine"
}

resource "digitalocean_tag" "persistent_cluster_machine" {
  name = "persistent_cluster_machine"
}

#
# Global volumes, used to store things I need
#
resource "digitalocean_volume" "git_storage" {
  region = "${var.digitalocean_region}"
  name = "git_storage"
  initial_filesystem_type = "ext4"
  size = "100"
}

resource "digitalocean_volume" "docker_registry_storage" {
  region = "${var.digitalocean_region}"
  name = "docker_registry_storage"
  initial_filesystem_type = "ext4"
  size = "100"
}

data "external" "swarm_join_token" {
  program = ["bash", "${path.root}/scripts/fetch_join_token.sh"]
  query = {
    host = "${digitalocean_droplet.cluster_master.ipv4_address}"
  }
}

resource "digitalocean_ssh_key" "cluster_key" {
  name = "${var.digitalocean_key_name}"
  public_key = "${file(var.public_key_path)}"
}

resource "digitalocean_droplet" "cluster_master" {
  # TODO: Include an env here
  name = "cluster-master"
  tags = ["${digitalocean_tag.exposed_cluster_machine.id}"]
  region = "${var.digitalocean_region}"
  size = "${var.digitalocean_master_droplet_size}"
  ssh_keys = ["${digitalocean_ssh_key.cluster_key.id}"]
  image = "${var.digitalocean_image}"
  private_networking = true
  ipv6 = true

  provisioner "remote-exec" {
    script = "scripts/install_docker.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "docker swarm init --advertise-addr ${digitalocean_droplet.cluster_master.ipv4_address_private}"
    ]
  }
}

# TODO: all workers will have the persistent volume mounted
resource "digitalocean_droplet" "cluster_worker" {
  # TODO: This should be configurable
  count = 1
  name = "cluster-worker-${count.index}"

  # TODO: Include an env here
  region = "${var.digitalocean_region}"
  size = "${var.digitalocean_worker_droplet_size}"
  image = "${var.digitalocean_image}"
  ssh_keys = ["${digitalocean_ssh_key.cluster_key.id}"]
  private_networking = true

  user_data = <<EOF
# cloud-config
manage-resolv-conf: true
resolv_conf:
  nameservers:
    - '1.1.1.1'
EOF

  # Only worker clusters gets volumes mounted..
  volume_ids = [
    "${digitalocean_volume.git_storage.id}",
    "${digitalocean_volume.docker_registry_storage.id}"
  ]

  provisioner "remote-exec" {
    script = "scripts/install_docker.sh"
  }

  provisioner "remote-exec" {
    script = "scripts/mount_storage_volumes.sh"
  }

  # Add cluster label to worker nodes so we can set constraints for services
  provisioner "remote-exec" {
    inline = [
      "docker swarm join ${data.external.swarm_join_token.result.worker} ${digitalocean_droplet.cluster_master.ipv4_address_private}:2377",
      "docker node --label-add allows=persistence"
    ]
  }
}
