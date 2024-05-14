

resource "google_compute_instance" "vpc-vm-tf" {
  machine_type = "e2-medium"
  name         = "vpc-vm-tf"
  zone         = "us-central1-a"
  metadata     = {
  startup-script = file("script2.sh")
}
  boot_disk {
    auto_delete = true
    device_name = "vpc-vm-tf"
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }
  network_interface {
    access_config {
      network_tier = "STANDARD"
    }
    subnetwork = google_compute_subnetwork.public-subnet-tf.self_link
    network    = google_compute_network.vpc-tf.self_link
  }
}