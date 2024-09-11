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
  name                      = var.instance_name
  project                   = var.project_name
  zone                      = var.zone
  machine_type              = "e2-micro"
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = var.os_image
    }
  }
  metadata_startup_script = "#!/bin/bash\nset -e\necho \"*****    Installing Nginx    *****\"\napt update\napt install -y nginx\nufw allow 'Nginx HTTP'\nsystemctl enable nginx\nsystemctl restart nginx\n \necho \"*****   Installation Complteted!!   *****\"\n \necho \"Welcome to Google Compute VM Instance deployed using Terraform!!!\" > /var/www/html/index.html\n \necho \"*****   Startup script completes!!    *****\"\n"
  network_interface {
    # A default network is created for all GCP projects
    network    = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.vpc_subnetwork.id
    access_config {
    }
  }
}