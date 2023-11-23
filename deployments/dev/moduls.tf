# This block declares a Terraform module to create a new service account.
module "service_account" {
  count        = 1
  source       = "../../modules/service_account" # Specifies the relative path to the service account module.
  account_id   = local.sa_account_id             # Sets the service account ID using a value from local variables.
  display_name = local.sa_display_name           # Assigns a human-readable name to the service account.
  project_id   = local.project_id                # Defines the Google Cloud project ID where the service account will be created.
}

# This module block creates a disk backup policy using a specified module.
module "disk_policy" {
  count          = 1
  source         = "../../modules/disk_policy" # Specifies the relative path to the disk policy module.
  project_id     = local.project_id            # Sets the Google Cloud project ID where the policy will be applied.
  region         = local.region                # Defines the region for applying the disk policy.
  name           = local.dp_name               # Assigns a name to the backup policy.
  description    = local.dp_description        # Provides a description for the backup policy.
  start_time     = local.dp_start_time         # Configures the start time for the backup policy.
  retention_days = local.dp_retention_days     # Sets the number of days for retaining snapshots.
  days_in_cycle  = local.dp_days_in_cycle      # Defines the frequency of the backup cycle in days.
}

# Module block for creating a virtual machine (VM) instance with specified properties.
module "virtual_machine" {
  count                 = length(local.vm_name)
  source                = "../../modules/virtual_machine"                        # Path to the virtual machine module.
  project_id            = local.project_id                                       # ID of the Google Cloud project where the VM is created.
  name                  = local.vm_name[count.index]                             # Name assigned to the VM instance.
  type                  = local.vm_type                                          # Machine type for the VM, defining CPU and memory.
  zone                  = local.zone                                             # Zone where the VM will be deployed.
  network_name          = local.vm_network_name                                  # Network to which the VM will be connected.
  disk_size             = local.vm_disk_size                                     # Size of the VM's boot disk.
  image                 = local.vm_image                                         # Boot image used for the VM.
  backup_policy         = module.disk_policy[0].google_compute_resource_policy.id # Backup policy associated with the VM.
  service_account_email = module.service_account[0].google_service_account.email    # Service account email associated with the VM.

  # Ensures that the VM is created only after the specified modules are successfully provisioned.
  depends_on = [
    module.disk_policy, module.service_account
  ]
}

# Module block for creating a persistent disk with specified properties using the 'disks' module.
module "disk" {
  count         = length(local.disk_name)
  source        = "../../modules/disk"         # Path to the disks module.
  project_id    = local.project_id             # Google Cloud project ID for disk creation.
  zone          = local.zone                   # Zone where the disk will be deployed.
  disk_name     = local.disk_name[count.index] # Name assigned to the disk.
  device_name   = local.disk_mnt_name[count.index]
  disk_type     = local.disk_type        # Type of the disk (e.g., pd-standard).
  disk_size     = local.disk_size        # Size of the disk in GB.
  backup_policy = module.disk_policy[0].google_compute_resource_policy.id     # Backup policy to be associated with the disk.
  instance_id   = module.virtual_machine[0].google_compute_instance.id # ID of the VM instance to which the disk will be attached.

  # Ensures that the disk is created only after the specified modules are provisioned.
  depends_on = [
    module.virtual_machine, module.disk_policy
  ]
}

# Module block to run Ansible playbooks for configuration management on a provisioned VM.
module "ansible1" {
  source         = "../../modules/ansible"
  path_to_script = local.ansible_disk_add_path
  vm_name        = local.vm_name[0]
  vm_zone        = module.virtual_machine[0].google_compute_instance.zone
  ansible_extra_vars = {
    disk_name   = local.disk_mnt_name[0],
    mnt_name    = local.disk_mnt_name[0],
    permissions = local.disk_migration_permissions
    owner       = local.disk_migration_owner
    group       = local.disk_migration_group
  }
  depends_on = [module.virtual_machine, module.disk]
}


# Module block to run Ansible playbooks for configuration management on a provisioned VM.
module "ansible2" {
  source         = "../../modules/ansible"      # Path to the Ansible module.
  path_to_script = local.ansible_swap_disk_path # Path to the Ansible playbook.
  vm_name        = local.vm_name[0]             # Public IP of the provisioned VM.
  vm_zone        = module.virtual_machine[0].google_compute_instance.zone

  # Ensures that Ansible is executed only after VM and disk provisioning.
  depends_on = [module.virtual_machine, module.disk]
}

output "gcloud-connect" {
  description = "The public ip address of the server"
  value       = "gcloud compute ssh ${local.vm_name[0]} or gcloud compute ssh ${local.vm_name[1]}"
}

