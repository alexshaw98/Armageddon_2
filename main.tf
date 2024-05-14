# Resource for creating a VPC with a subnet and firewall rule in GCP using Terraform

# Creating the VPC
resource "google_compute_network" "vpc-tf" {
 name                    = "vpc-tf" 
 auto_create_subnetworks = false
 routing_mode            = "REGIONAL"
}

# Creating the subnet
resource "google_compute_subnetwork" "public-subnet-tf" {
  name          = "public-subnet-tf"
  network       = google_compute_network.vpc-tf.name
  region        = "us-central1"
  ip_cidr_range = "10.187.13.0/24"
}

# Creating the router
resource "google_compute_router" "vpc-network-router-us-tf" {
  name    = "vpc-network-router-us-tf"
  region  = "us-central1"
  network = google_compute_network.vpc-tf.name
}

# Creating the firewall rule
resource "google_compute_route" "vpc-network-route-tf" {
  name             = "vpc-network-route-tf"
  dest_range       = "0.0.0.0/0"
  network          = google_compute_network.vpc-tf.name
  next_hop_gateway = "default-internet-gateway"
}

resource "google_compute_firewall" "allow-mgmt-traffic-tf" {
  name      = "allow-mgmt-traffic-tf"
  network   = google_compute_network.vpc-tf.name
  direction = "INGRESS"
  priority  = 1000

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["vpc-network-ssh"]
}

resource "google_compute_firewall" "vpc-allow-egress-tf" {
  name        = "vpc-allow-egress-tf"
  network     = google_compute_network.vpc-tf.name
  direction   = "EGRESS"
  priority    = 1000
  allow {
    protocol  = "all"
  }
  destination_ranges = ["0.0.0.0/0"]
  target_tags = ["vpc-network-egress"]
}

# Creating the ingress firewall rule
resource "google_compute_firewall" "vpc-allow-ingress-tf" {
  name      = "vpc-allow-ingress-tf"
  network   = google_compute_network.vpc-tf.name
  direction = "INGRESS"
  priority  = 1000
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = [ "vpc-ingress-tp" ]
}

resource "google_compute_firewall" "vpc-allow-mgmt-tf" {
  name      = "pc-allow-mgmt-tf"
  network   = google_compute_network.vpc-tf.name
  direction = "INGRESS"
  priority  = 1000

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["vpc-network-ssh"]
}


resource "google_compute_firewall" "allow_web_traffic" {
  name    = "allow-web-traffic"
  network = google_compute_network.vpc-tf.name
  direction = "INGRESS"
  priority = 1000

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
    source_ranges = ["0.0.0.0/0"]
  target_tags = ["vpc-network-web"]
}