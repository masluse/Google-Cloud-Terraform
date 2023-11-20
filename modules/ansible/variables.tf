variable "path_to_script" {
  type        = string
  description = "The file path to the Ansible playbook"
}

variable "vm_name" {
  type        = list
  description = "The public IP address of the target machine for Ansible"
}

variable "ansible_extra_vars" {
  description = "Extra variables to pass to the Ansible playbook"
  type        = map(string)
  default     = {}
}

variable "vm_zone" {
  type        = string
  description = "Zone of the vm that Ansible should connect to"
}

# Local values for processing extra variables
locals {
  # Converts ansible_extra_vars map to a string format for the ansible command
  extra_vars_string = join(" ", [for k, v in var.ansible_extra_vars : format("%s='%s'", k, tostring(v))])

  # Creates the --extra-vars argument for ansible-playbook if extra vars are present
  ansible_extra_vars_command = length(var.ansible_extra_vars) > 0 ? format("--extra-vars '%s'", local.extra_vars_string) : ""
}
