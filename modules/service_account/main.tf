# This Terraform resource is responsible for creating a Google Cloud service account.
resource "google_service_account" "default" {
  account_id   = var.account_id   # The ID for the service account, sourced from module variables.
  display_name = var.display_name # The display name for the service account, sourced from module variables.
  project      = var.project_id   # Specifies the Google Cloud project where the service account is to be created.
}