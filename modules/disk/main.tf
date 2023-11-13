# Resource block for defining a Google Compute Engine disk.
resource "google_compute_disk" "default" {
  project = var.project_id # Google Cloud project ID.
  name    = var.disk_name  # Name of the disk.
  type    = var.disk_type  # Type of the disk.
  zone    = var.zone       # Zone where the disk is deployed.
  size    = var.disk_size  # Size of the disk in GB.
}

# Resource block for attaching a resource policy to the Compute Engine disk.
resource "google_compute_disk_resource_policy_attachment" "default" {
  count   = var.backup_policy != "" ? 1 : 0 # Conditionally creates this resource if a backup policy is specified.
  project = var.project_id                  # Google Cloud project ID.
  name    = var.backup_policy               # Name of the backup policy to attach.
  disk    = var.disk_name                   # Name of the disk to which the policy is attached.
  zone    = var.zone                        # Zone where the disk is located.

  # Dependency to ensure attachment occurs after the disk is created.
  depends_on = [
    resource.google_compute_disk.default
  ]
}

# Resource block for attaching the disk to a Compute Engine instance.
resource "google_compute_attached_disk" "default" {
  count    = var.instance_id != "" ? 1 : 0  # Conditionally creates this resource if an instance ID is specified.
  project  = var.project_id                 # Google Cloud project ID.
  device_name = var.disk_name
  zone     = var.zone                       # Zone where the instance and disk are located.
  disk     = google_compute_disk.default.id # ID of the disk to attach.
  instance = var.instance_id                # ID of the instance to which the disk will be attached.

  # Dependency to ensure the disk is attached after it is created.
  depends_on = [
    resource.google_compute_disk.default
  ]
}