resource "google_compute_instance" "default" {
  name         = var.vm_name
  machine_type = var.vm_type
  zone         = var.vm_zone

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-jammy-v20231030"
      size  = 10
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
  project = var.project_id
  name = var.backup_policy
  disk = var.vm_name
  zone = var.vm_zone
}