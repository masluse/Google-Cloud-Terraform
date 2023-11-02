variable "project_id" {
  description = "The project ID where the snapshot schedule will be created"
}

variable "bp_name" {
  description = "The name of the snapshot schedule"
}

variable "bp_description" {
  description = "The description of the snapshot schedule"
  default     = "Daily snapshots at midnight, retained for 10 days"
}

variable "region" {
  description = "The region where the snapshot schedule will be created"
}

variable "bp_start_time" {
  description = "The start time of the Backup"
}

variable "bp_retention_days" {
  description = "Backup retention days"
}