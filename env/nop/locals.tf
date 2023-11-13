# Define local variables for reuse within this Terraform module.
locals {
  # Script path
  ansible_disk_add_path = "../../scripts/ansible/disk_add.yaml"

  # Project configuration
  project_id = "prj-obilab-5873628173-mrtf" # Unique identifier for the project.
  region     = "europe-west6"               # Region where resources will be provisioned.
  zone       = "europe-west6-a"             # Specific zone within the region.

  # Service Account configuration for secure API management.
  sa1_account_id   = "sa-manuel-manuel02"   # ID for the service account.
  sa1_display_name = "Test Service Account" # User-friendly name for the service account.

  # Backup policy settings to define snapshot schedule and retention.
  dp1_name           = "nightly-snapshots"                      # Name for the snapshot policy.
  dp1_description    = "Nightly snapshots retained for 10 days" # Description of backup policy.
  dp1_start_time     = "02:00"                                  # Time when the snapshot process starts.
  dp1_retention_days = "10"                                     # Number of days to retain the snapshots.
  dp1_days_in_cycle  = "1"                                      # Frequency of the snapshot cycle in days.

  # VM (Virtual Machine) configuration to specify the compute resources.
  vm1_name         = "vm-1"                                        # Name identifier for the virtual machine.
  vm1_type         = "e2-micro"                                    # Machine type specifying a particular CPU/RAM configuration.
  vm1_network_name = "default"                                     # The network to which the VM is connected.
  vm1_image        = "ubuntu-os-cloud/ubuntu-2204-jammy-v20231030" # OS image for the VM.
  vm1_disk_size    = 10                                            # Size of the VM's primary disk in GB.

  # Additional disk configurations for attachable storage.
  disk1_name = "migration"   # Identifier for the first additional disk.
  disk1_type = "pd-standard" # Disk type; 'pd-standard' is a standard persistent disk.
  disk1_size = 10            # Size of the disk in GB.

  # Additional disk configurations for attachable storage.
  disk2_name = "additional"  # Identifier for the first additional disk.
  disk2_type = "pd-standard" # Disk type; 'pd-standard' is a standard persistent disk.
  disk2_size = 10            # Size of the disk in GB.
}