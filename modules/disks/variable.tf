variable "project_id" {
  type        = string
  description = "Project ID"
}

variable "disk_name" {
  type        = string
  description = "Name of disk"
}

variable "disk_type" {
  type        = string
  description = "Type of the disk"
}

variable "disk_size" {
  type        = number
  description = "Size of the disk"
}

variable "zone" {
  type        = string
  description = "Zone"
}

variable "backup_policy" {
  type        = string
  description = "Backup policy for the disk"
  default = ""
}

variable "instance_id" {
  type        = string
  description = "Virtual Machine instance ID"
  default = ""
}