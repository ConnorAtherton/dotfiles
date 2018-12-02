output "public_ip" {
  value = "${digitalocean_droplet.cluster_master.ipv4_address}"
}
