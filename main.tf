resource "google_compute_network" "vpc_network" {
  name                    = "tf-vpc-network"
  project                 = var.project_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "vpc_subnetwork" {
  name          = var.subnetwork
  project       = var.project_name
  ip_cidr_range = "10.20.0.0/16"
  region        = "us-central1"
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_instance" "vm_instance" {
  name         = var.instance_name
  project      = var.project_name
  zone         = "us-central1-a"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = var.os_image
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network    = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.vpc_subnetwork.id
    access_config {
    }
  }
}
