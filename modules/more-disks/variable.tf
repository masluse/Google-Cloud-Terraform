variable "disk_name" {
  type        = string
  description = "Name of disk"
}

variable "disk_type" {
  type        = string
  description = "Type of the disk"
}

variable "vm_zone" {
  type        = string
  description = "Zone"
}

variable "disk_size" {
  type        = string
  description = "Size of the disk"
}

variable "project_id" {
  type        = string
  description = "Project ID"
}

variable "backup_policy" {
  type        = string
  description = "Backup policy for the disk"
}