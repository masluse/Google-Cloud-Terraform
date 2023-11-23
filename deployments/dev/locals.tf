# Define local variables for reuse within this Terraform module.
locals {
  # Compute Engine configuration
  project_id = "prj-obilab-5873628173-mrtf" # ID of the project to deploy resources to.
  region     = "europe-west6"               # Region to deploy resources to.
  zone       = "europe-west6-a"             # Zone to deploy resources to.

  # Service Account configuration for secure API management.
  cloud-plattform_sa_account-id   = "sa-manuel-manuel02"   # ID of the service account.
  cloud-plattform_sa_display-name = "Test Service Account" # Display name of the service account.

  # Backup policy settings to define snapshot schedule and retention.
  compute-engine_dp_name           = "nightly-snapshots"                      # Name for the snapshot policy.
  compute-engine_dp_description    = "Nightly snapshots retained for 10 days" # Description of backup policy.
  compute-engine_dp_start-time     = "02:00"                                  # Time when the snapshot process starts.
  compute-engine_dp_retention-days = "10"                                     # Number of days to retain the snapshots.
  compute-engine_dp_days-in-cycle  = "1"                                      # Frequency of the snapshot cycle in days.

  # VM configuration to specify the VMs.
  compute-engine_vm_name         = ["vm-1", "vm-2"]                              # Name identifier for the VM.
  compute-engine_vm_type         = "e2-micro"                                    # Type of machine to create.
  compute-engine_vm_network-name = "default"                                     # Name identifier for the network.
  compute-engine_vm_image        = "ubuntu-os-cloud/ubuntu-2204-jammy-v20231030" # The image to use for the VM.
  compute-engine_vm_disk-size    = 10                                            # Size of the boot disk in GB.

  # Disk configuration to specify the additional disks.
  compute-engine_disk_name     = ["google-vm1-migration", "google-swap"] # Name identifier for the disk.
  compute-engine_disk_mnt-name = ["migrations", "swap"]                  # Name identifier for the disk mount.
  compute-engine_disk_type     = "pd-standard"                           # Type of disk to create.
  compute-engine_disk_size     = 10                                      # Size of the disk in GB.

  # Ansible configuration
  ansible_path_disk_add              = "../../scripts/ansible/disk_add.yaml"  # Path to the disk add script.
  ansible_path_swap_disk             = "../../scripts/ansible/swap_disk.yaml" # Path to the swap disk script.
  ansible_disk_migration-permissions = "0777"                                 # Permissions for the disk.
  ansible_disk_migration-owner       = "root"                                 # Owner for the disk.
  ansible_disk_migration-group       = "root"                                 # Group for the disk.

}