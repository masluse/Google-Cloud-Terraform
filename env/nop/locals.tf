locals {
  project_id = "prj-obilab-5873628173-mrtf" # Project ID
  region     = "europe-west6"
  zone       = "europe-west6-a" # Zone

  # Service Account configuration
  sa1_account_id   = "sa-manuel-manuel02"   # SA Account ID
  sa1_display_name = "Test Service Account" # SA Account name

  # Backup policy
  dp1_name           = "nightly-snapshots"
  dp1_description    = "Nightly snapshots retained for 10 days"
  dp1_start_time     = "02:00"
  dp1_retention_days = "10"
  dp1_days_in_cycle  = "1"

  # VM configuration
  vm1_name         = "vm-1"     # VM name
  vm1_type         = "e2-micro" # VM type
  vm1_network_name = "default"  # Network name for the Vm
  vm1_image        = "ubuntu-os-cloud/ubuntu-2204-jammy-v20231030"
  vm1_disk_size    = 10

  disk1_name = "disk-1"
  disk1_type = "pd-standard"
  disk1_size = 10

  disk2_name = "disk-2"
  disk2_type = "pd-standard"
  disk2_size = 10
}