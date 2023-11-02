terraform {
  required_version = "~> 1.6"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.40"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 4.40"
    }
  }

  backend "gcs" {
    bucket = "tfs-95582189762515327052"
    prefix = "tfs/dep/obilab-gcp-matf"
  }
}