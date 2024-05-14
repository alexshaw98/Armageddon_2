

output "vpc_name" {
  value = google_compute_network.vpc-tf.name
}

output "public_IP" {
  value = google_compute_subnetwork.public-subnet-tf.gateway_address
}

output "website_url" {
  value = "http://${google_compute_instance.vpc-vm-tf.network_interface.0.access_config.0.nat_ip}"
}

output "internal_ip" {
  value = google_compute_instance.vpc-vm-tf.network_interface.0.network_ip
}

output "vm_subnet" {
  value = google_compute_subnetwork.public-subnet-tf.ip_cidr_range
}
