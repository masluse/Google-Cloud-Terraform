resource "google_compute_disk" "default" {
  project = var.project_id
  name  = var.disk_name
  type  = var.disk_type
  zone  = var.vm_zone
  size  = var.disk_size
}

resource "google_compute_disk_resource_policy_attachment" "attachment" {
  project = var.project_id
  name = var.backup_policy
  disk = var.vm_name
  zone = var.vm_zone
}