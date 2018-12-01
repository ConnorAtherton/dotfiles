variable "digitalocean_token" {
}

variable "public_key_path" {
  default = "~/.ssh/catherton-cluster/id_rsa.pub"
}

variable "digitalocean_region" {
  default = "nyc3"
}

variable "digitalocean_master_droplet_size" {
  default = "512mb"
}

variable "digitalocean_worker_droplet_size" {
  default = "512mb"
}

variable "digitalocean_image" {
  default = "ubuntu-16-04-x64"
}

variable "digitalocean_key_name" {
  default = "catherton-cluster"
}

