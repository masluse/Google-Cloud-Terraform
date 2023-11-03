variable "project_id" {
  description = "The project ID where the snapshot schedule will be created"
}

variable "region" {
  description = "The region where the snapshot schedule will be created"
}

variable "name" {
  description = "The name of the snapshot schedule"
}

variable "description" {
  description = "The description of the snapshot schedule"
  default     = "Daily snapshots at midnight, retained for 10 days"
}

variable "start_time" {
  description = "The start time of the Backup"
}

variable "retention_days" {
  description = "Backup retention days"
}

variable "days_in_cycle" {
  description = "Days in cycle"
}