variable "project_id" {
  type        = string
  description = "The project ID to host the VM in"
}

variable "name" {
  type        = string
  description = "The name of the VM instance to create"
}

variable "service_account_email" {
  type        = string
  description = "The service account email attached to the VM"
}

variable "network_name" {
  type        = string
  description = "The name of the VPC network to attach the VM"
}

variable "type" {
  type        = string
  description = "Virtual Machine type"
}

variable "zone" {
  type        = string
  description = "Virtual Machine zone"
}

variable "backup_policy" {
  type        = string
  description = "Backup policy for the disk"
}

variable "image" {
  type        = string
  description = "Image of Virtual Machine"
}

variable "disk_size" {
  type        = string
  description = "Disk size of disk"
}