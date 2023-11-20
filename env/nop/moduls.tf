# This block declares a Terraform module to create a new service account.
module "sa1" {
  source       = "../../modules/service_account" # Specifies the relative path to the service account module.
  account_id   = local.sa1_account_id            # Sets the service account ID using a value from local variables.
  display_name = local.sa1_display_name          # Assigns a human-readable name to the service account.
  project_id   = local.project_id                # Defines the Google Cloud project ID where the service account will be created.
}

# This module block creates a disk backup policy using a specified module.
module "dp1" {
  source         = "../../modules/disk_policy" # Specifies the relative path to the disk policy module.
  project_id     = local.project_id            # Sets the Google Cloud project ID where the policy will be applied.
  region         = local.region                # Defines the region for applying the disk policy.
  name           = local.dp1_name              # Assigns a name to the backup policy.
  description    = local.dp1_description       # Provides a description for the backup policy.
  start_time     = local.dp1_start_time        # Configures the start time for the backup policy.
  retention_days = local.dp1_retention_days    # Sets the number of days for retaining snapshots.
  days_in_cycle  = local.dp1_days_in_cycle     # Defines the frequency of the backup cycle in days.
}

# Module block for creating a virtual machine (VM) instance with specified properties.
module "vm1" {
  source                = "../../modules/virtual_machine"                # Path to the virtual machine module.
  project_id            = local.project_id                               # ID of the Google Cloud project where the VM is created.
  name                  = local.vm1_name                                 # Name assigned to the VM instance.
  type                  = local.vm1_type                                 # Machine type for the VM, defining CPU and memory.
  zone                  = local.zone                                     # Zone where the VM will be deployed.
  network_name          = local.vm1_network_name                         # Network to which the VM will be connected.
  disk_size             = local.vm1_disk_size                            # Size of the VM's boot disk.
  image                 = local.vm1_image                                # Boot image used for the VM.
  backup_policy         = module.dp1.google_compute_resource_policy.name # Backup policy associated with the VM.
  service_account_email = module.sa1.google_service_account.email        # Service account email associated with the VM.

  # Ensures that the VM is created only after the specified modules are successfully provisioned.
  depends_on = [
    module.dp1, module.sa1
  ]
}

# Module block for creating a virtual machine (VM) instance with specified properties.
module "vm2" {
  source                = "../../modules/virtual_machine"                # Path to the virtual machine module.
  project_id            = local.project_id                               # ID of the Google Cloud project where the VM is created.
  name                  = local.vm2_name                                 # Name assigned to the VM instance.
  type                  = local.vm2_type                                 # Machine type for the VM, defining CPU and memory.
  zone                  = local.zone                                     # Zone where the VM will be deployed.
  network_name          = local.vm2_network_name                         # Network to which the VM will be connected.
  disk_size             = local.vm2_disk_size                            # Size of the VM's boot disk.
  image                 = local.vm2_image                                # Boot image used for the VM.
  backup_policy         = module.dp1.google_compute_resource_policy.name # Backup policy associated with the VM.
  service_account_email = module.sa1.google_service_account.email        # Service account email associated with the VM.

  # Ensures that the VM is created only after the specified modules are successfully provisioned.
  depends_on = [
    module.dp1, module.sa1
  ]
}

# Module block for creating a persistent disk with specified properties using the 'disks' module.
module "disk1" {
  source        = "../../modules/disk"                           # Path to the disks module.
  project_id    = local.project_id                               # Google Cloud project ID for disk creation.
  zone          = local.zone                                     # Zone where the disk will be deployed.
  disk_name     = local.disk1_name                               # Name assigned to the disk.
  device_name = local.disk1_mnt_name
  disk_type     = local.disk1_type                               # Type of the disk (e.g., pd-standard).
  disk_size     = local.disk1_size                               # Size of the disk in GB.
  backup_policy = module.dp1.google_compute_resource_policy.name # Backup policy to be associated with the disk.
  instance_id   = module.vm1.google_compute_instance.name        # ID of the VM instance to which the disk will be attached.

  # Ensures that the disk is created only after the specified modules are provisioned.
  depends_on = [
    module.vm1, module.dp1
  ]
}

# Module block for creating a persistent disk with specified properties using the 'disks' module.
module "disk2" {
  source        = "../../modules/disk"                           # Path to the disks module.
  project_id    = local.project_id                               # Google Cloud project ID for disk creation.
  zone          = local.zone                                     # Zone where the disk will be deployed.
  disk_name     = local.disk2_name                               # Name assigned to the disk.
  device_name = local.disk2_mnt_name
  disk_type     = local.disk2_type                               # Type of the disk (e.g., pd-standard).
  disk_size     = local.disk2_size                               # Size of the disk in GB.
  backup_policy = module.dp1.google_compute_resource_policy.name # Backup policy to be associated with the disk.
  instance_id   = module.vm1.google_compute_instance.name        # ID of the VM instance to which the disk will be attached.

  # Ensures that the disk is created only after the specified modules are provisioned.
  depends_on = [
    module.vm1, module.dp1
  ]
}

# Module block to run Ansible playbooks for configuration management on a provisioned VM.
module "ansible1" {
  source            = "../../modules/ansible"
  path_to_script    = local.ansible_disk_add_path
  vm_name           = local.ansible
  vm_zone           = module.vm1.google_compute_instance.zone
  ansible_extra_vars = {
    disk_name    = local.disk1_mnt_name,
    mnt_name     = local.disk1_mnt_name,
    permissions  = local.disk1_permissions
    owner = local.disk1_owner
    group = local.disk1_group
  }
  depends_on        = [module.vm1, module.disk1]
}


# Module block to run Ansible playbooks for configuration management on a provisioned VM.
module "ansible2" {
  source         = "../../modules/ansible"     # Path to the Ansible module.
  path_to_script = local.ansible_swap_disk_path # Path to the Ansible playbook.
  vm_name        = local.vm1_name             # Public IP of the provisioned VM.
  vm_zone        = module.vm1.google_compute_instance.zone

  # Ensures that Ansible is executed only after VM and disk provisioning.
  depends_on = [module.vm1, module.disk2]
}

output "gcloud-connect" {
  description = "The public ip address of the server"
  value       = "gcloud compute ssh ${local.vm1_name}"
}