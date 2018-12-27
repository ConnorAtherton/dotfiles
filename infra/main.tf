provider "digitalocean" {
  token = "${var.digitalocean_token}"
}

#
# Global volumes, used to store things I need
#
data "digitalocean_volume" "git_storage" {
  name   = "persistent_git_storage"
  region = "${var.digitalocean_region}"
}

data "digitalocean_volume" "docker_registry_storage" {
  name   = "persistent_docker_registry_storage"
  region = "${var.digitalocean_region}"
}

data "digitalocean_floating_ip" "external_gateway_ip" {
  ip_address = "${var.external_ip}"
}

data "digitalocean_floating_ip" "internal_gateway_ip" {
  ip_address = "${var.internal_ip}"
}

resource "digitalocean_ssh_key" "cluster_key" {
  name       = "${var.digitalocean_key_name}"
  public_key = "${file(var.public_key_path)}"
}

# resource "digitalocean_droplet" "external_gateway" {
#   name               = "external-gateway"
#   region             = "${var.digitalocean_region}"
#   size               = "${var.digitalocean_master_droplet_size}"
#   ssh_keys           = ["${digitalocean_ssh_key.cluster_key.id}"]
#   image              = "${var.digitalocean_image}"
#   private_networking = true
#   ipv6               = true

#   user_data = <<EOF
# # cloud-config
# manage-resolv-conf: true
# resolv_conf:
#   nameservers:
#     - '1.1.1.1'
# EOF

#   provisioner "remote-exec" {
#     script = "scripts/install_docker.sh"
#   }

#   provisioner "remote-exec" {
#     script = "scripts/provision_linux.sh"
#   }
# }

resource "digitalocean_droplet" "internal_gateway" {
  name               = "internal-gateway"
  region             = "${var.digitalocean_region}"
  size               = "${var.digitalocean_worker_droplet_size}"
  image              = "${var.digitalocean_image}"
  ssh_keys           = ["${digitalocean_ssh_key.cluster_key.id}"]
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
    "${data.digitalocean_volume.git_storage.id}",
    "${data.digitalocean_volume.docker_registry_storage.id}",
  ]

  provisioner "remote-exec" {
    script = "scripts/install_docker.sh"
  }

  provisioner "remote-exec" {
    script = "scripts/provision_linux.sh"
  }

  provisioner "remote-exec" {
    script = "scripts/mount_storage_volumes.sh"
  }
}

#
# All resources beyond this point are not managed by terraform, since they are persistent and global.
# Instead, they are to be created manually before operating these scripts, and are attached differently so terraform
# does not take them as drift and try to delete them as a dependency of some other resource.
#
# resource "digitalocean_floating_ip_assignment" "external_ip_assignment" {
#   ip_address = "${data.digitalocean_floating_ip.external_gateway_ip.id}"
#   droplet_id = "${digitalocean_droplet.external_gateway.id}"
# }

resource "digitalocean_floating_ip_assignment" "internal_ip_assignment" {
  ip_address = "${data.digitalocean_floating_ip.internal_gateway_ip.id}"
  droplet_id = "${digitalocean_droplet.internal_gateway.id}"
}
