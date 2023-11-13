# Resource block for provisioning a Google Compute Engine instance.
resource "google_compute_instance" "default" {
  name         = var.name # Name of the VM instance.
  machine_type = var.type # Machine type (CPU and memory) for the VM.
  zone         = var.zone # Zone for VM deployment.

  # Configuration for the boot disk of the VM.
  boot_disk {
    initialize_params {
      image = var.image     # Image used for the boot disk.
      size  = var.disk_size # Size of the boot disk.
    }
  }

  # Network interface configuration for the VM.
  network_interface {
    network = var.network_name # Network to which the VM will be connected.
  }

  # Service account configuration for the VM.
  service_account {
    email  = var.service_account_email                          # Email of the service account associated with the VM.
    scopes = ["https://www.googleapis.com/auth/cloud-platform"] # Access scopes for the service account.
  }

  # Metadata configuration for the VM.
  metadata = {
    enable-oslogin = "true" # Enables OS Login for the VM.
  }

  # Tags assigned to the VM for identification and filtering.
  tags = ["ubuntu-vm", "iac-ssh"]

  project = var.project_id # Google Cloud project ID where the VM is located.
}

# Resource block for attaching a disk resource policy to a Compute Engine disk.
resource "google_compute_disk_resource_policy_attachment" "default" {
  count   = var.backup_policy != "" ? 1 : 0 # Conditionally creates this resource based on backup policy presence.
  project = var.project_id                  # Google Cloud project ID.
  name    = var.backup_policy               # Name of the backup policy to attach.
  disk    = var.name                        # Name of the disk to which the policy is attached.
  zone    = var.zone                        # Zone where the disk is located.

  # Ensures that the policy attachment is created only after the VM instance is provisioned.
  depends_on = [
    resource.google_compute_instance.default
  ]
}