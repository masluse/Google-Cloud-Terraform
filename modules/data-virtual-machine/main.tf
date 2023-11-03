data "google_compute_instance" "default" {
  name    = var.name
  zone    = var.zone
  project = var.project_id
}