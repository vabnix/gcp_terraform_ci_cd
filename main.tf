resource "google_compute_network" "vpc_network" {
  name                    = var.network
  project                 = var.project_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "vpc_subnetwork" {
  name          = var.subnetwork
  project       = var.project_name
  ip_cidr_range = "10.20.0.0/16"
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_instance" "vm_instance" {
  name         = var.instance_name
  project      = var.project_name
  zone         = var.zone
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

resource "google_compute_firewall" "default" {
  name    = var.firewall_name
  project = var.project_name
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "1000-2000"]
  }

  source_tags = ["web"]
}

