#
# These should be executed once to get global information
# that should persist throughout the terraform lifecycle.
#
resource "digitalocean_volume" "git_storage" {
  region                  = "${var.digitalocean_region}"
  name                    = "persistent_git_storage"
  initial_filesystem_type = "ext4"
  size                    = "100"
}

resource "digitalocean_volume" "docker_registry_storage" {
  region                  = "${var.digitalocean_region}"
  name                    = "persistent_docker_registry_storage"
  initial_filesystem_type = "ext4"
  size                    = "100"
}
