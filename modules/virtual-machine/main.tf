resource "google_compute_instance" "default" {
  name         = var.name
  machine_type = var.type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image
      size  = var.disk_size
    }
  }

  network_interface {
    network = var.network_name
  }

  service_account {
    email  = var.service_account_email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  metadata = {
    enable-oslogin = "true"
  }

  tags = ["ubuntu-vm"]

  project = var.project_id
}

resource "google_compute_disk_resource_policy_attachment" "attachment" {
  count   = var.backup_policy != "" ? 1 : 0
  project = var.project_id
  name    = var.backup_policy
  disk    = var.name
  zone    = var.zone
}