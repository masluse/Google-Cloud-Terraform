# Use the 'service-account' module to create a service account with the provided attributes.
module "sa1" {
  source       = "../../modules/service-account" # Relative path to the service account module.
  account_id   = local.sa1_account_id            # Service account ID derived from local variables.
  display_name = local.sa1_display_name          # Human-readable name for the service account.
  project_id   = local.project_id                # Google Cloud project ID where the service account will be created.
}

# Use the 'disk-policy' module to define a backup policy for disks.
module "dp1" {
  source         = "../../modules/disk-policy" # Relative path to the disk policy module.
  project_id     = local.project_id            # Google Cloud project ID for policy assignment.
  region         = local.region                # The region where the disk policy will be applied.
  name           = local.dp1_name              # Name of the backup policy.
  description    = local.dp1_description       # Description of the backup policy.
  start_time     = local.dp1_start_time        # Time of day when the backup policy starts.
  retention_days = local.dp1_retention_days    # Number of days the snapshots are kept.
  days_in_cycle  = local.dp1_days_in_cycle     # Frequency of the backup cycle in days.
}

# Use the 'virtual-machine' module to provision a VM instance with the defined properties.
module "vm1" {
  source                = "../../modules/virtual-machine"   # Relative path to the virtual machine module.
  project_id            = local.project_id                  # Google Cloud project ID where the VM will be created.
  name                  = local.vm1_name                    # The name of the VM instance.
  type                  = local.vm1_type                    # The machine type for the VM (defines CPU and memory).
  zone                  = local.zone                        # The zone where the VM will be deployed.
  network_name          = local.vm1_network_name            # The network the VM will be connected to.
  disk_size             = local.vm1_disk_size               # The size of the VM's boot disk.
  image                 = local.vm1_image                   # The boot image for the VM.
  backup_policy         = module.dp1.snapshot_schedule.name # Backup policy to be associated with the VM.
  service_account_email = module.sa1.service_account.email  # Service account to be associated with the VM.

  depends_on = [
    module.dp1, module.sa1
  ]
}

# Use the 'disks' module to create a persistent disk with the given specifications.
module "disk1" {
  source        = "../../modules/disks"             # Relative path to the disks module.
  project_id    = local.project_id                  # Google Cloud project ID where the disk will be created.
  zone          = local.zone                        # The zone where the disk will be deployed.
  disk_name     = local.disk1_name                  # The name of the disk.
  disk_type     = local.disk1_type                  # The type of the disk.
  disk_size     = local.disk1_size                  # The size of the disk.
  backup_policy = module.dp1.snapshot_schedule.name # Backup policy to be associated with the disk.
  instance_id   = module.vm1.compute_instance.name  # VM instance ID that the disk will be attached to.terr

  depends_on = [
    module.vm1, module.dp1
  ]
}

# Use the 'disks' module to create another persistent disk, similar to 'disk1'.
module "disk2" {
  source        = "../../modules/disks"             # Relative path to the disks module.
  project_id    = local.project_id                  # Google Cloud project ID where the disk will be created.
  zone          = local.zone                        # The zone where the disk will be deployed.
  disk_name     = local.disk2_name                  # The name of the disk.
  disk_type     = local.disk2_type                  # The type of the disk.
  disk_size     = local.disk2_size                  # The size of the disk.
  backup_policy = module.dp1.snapshot_schedule.name # Backup policy to be associated with the disk.
  instance_id   = module.vm1.compute_instance.name  # VM instance ID that the disk will be attached to.

  depends_on = [
    module.vm1, module.dp1
  ]
}

module "data-vm1" {
  source     = "../../modules/data-virtual-machine" # Relative path to the disks module.
  name       = local.vm1_name                       # Google Cloud project ID where the disk will be created.
  zone       = local.zone                           # The zone where the disk will be deployed.
  project_id = local.project_id                     # Google Cloud project ID where the disk will be created.

  depends_on = [
    module.vm1
  ]
}

output "instance_ip_addr" {
  value = module.data-vm1.serverinfo.network
}