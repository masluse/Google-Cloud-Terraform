resource "google_compute_disk" "default" {
  project = var.project_id
  name    = var.disk_name
  type    = var.disk_type
  zone    = var.zone
  size    = var.disk_size
}

resource "google_compute_disk_resource_policy_attachment" "attachment" {
  count   = var.backup_policy != "" ? 1 : 0
  project = var.project_id
  name    = var.backup_policy
  disk    = var.disk_name
  zone    = var.zone
}

resource "google_compute_attached_disk" "default" {
  count   = var.instance_id != "" ? 1 : 0
  disk     = google_compute_disk.default.id
  instance = var.instance_id
}