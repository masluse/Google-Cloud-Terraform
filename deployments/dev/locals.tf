# Define local variables for reuse within this Terraform module.
locals {
  # Script path
  ansible_disk_add_path  = "../../scripts/ansible/disk_add.yaml"
  ansible_swap_disk_path = "../../scripts/ansible/swap_disk.yaml"

  # Project configuration
  project_id = "prj-obilab-5873628173-mrtf" # Unique identifier for the project.
  region     = "europe-west6"               # Region where resources will be provisioned.
  zone       = "europe-west6-a"             # Specific zone within the region.

  # Service Account configuration for secure API management.
  sa_account_id   = "sa-manuel-manuel02"   # ID for the service account.
  sa_display_name = "Test Service Account" # User-friendly name for the service account.

  # Backup policy settings to define snapshot schedule and retention.
  dp_name           = "nightly-snapshots"                      # Name for the snapshot policy.
  dp_description    = "Nightly snapshots retained for 10 days" # Description of backup policy.
  dp_start_time     = "02:00"                                  # Time when the snapshot process starts.
  dp_retention_days = "10"                                     # Number of days to retain the snapshots.
  dp_days_in_cycle  = "1"                                      # Frequency of the snapshot cycle in days.

  # VM (Virtual Machine) configuration to specify the compute resources.
  vm_name         = ["vm-1", "vm-2"]                              # Name identifier for the virtual machine.
  vm_type         = "e2-micro"                                    # Machine type specifying a particular CPU/RAM configuration.
  vm_network_name = "default"                                     # The network to which the VM is connected.
  vm_image        = "ubuntu-os-cloud/ubuntu-2204-jammy-v20231030" # OS image for the VM.
  vm_disk_size    = 10

  disk_name     = ["google-vm1-migration", "google-swap"] # Identifier for the first additional disk.
  disk_mnt_name = ["migrations", "swap"]                  # Identifier for the first additional disk.
  disk_type     = "pd-standard"                           # Disk type; 'pd-standard' is a standard persistent disk.
  disk_size     = 10                                      # Size of the disk in GB.

  disk_migration_permissions = "0777"
  disk_migration_owner       = "root"
  disk_migration_group       = "root"
}