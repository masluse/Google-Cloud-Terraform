data "google_compute_instance" "appserver" {
  name    = var.name
  zone    = var.zone
  project = var.project_id
}