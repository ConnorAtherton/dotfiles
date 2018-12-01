output "public_ip" {
  value = "${digitalocean_droplet.cluster_master.ipv4_address}"
}

output "worker_join_token" {
  value = "${data.external.swarm_join_token.result.worker} ${digitalocean_droplet.cluster_master.ipv4_address_private}"
}

output "manager_join_token" {
  value = "${data.external.swarm_join_token.result.manager} ${digitalocean_droplet.cluster_master.ipv4_address_private}"
}
