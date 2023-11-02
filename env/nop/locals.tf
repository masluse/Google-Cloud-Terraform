locals {
  project_id = "prj-obilab-5873628173-mrtf" # Project ID
  region     = "europe-west6"

  # Service Account configuration
  account_id   = "sa-manuel-manuel02"   # SA Account ID
  display_name = "Test Service Account" # SA Account name

  # Backup policy
  bp_name           = "nightly-snapshots"
  bp_description    = "Nightly snapshots retained for 10 days"
  bp_start_time     = "02:00"
  bp_retention_days = "10"

  # VM configuration
  vm_name      = "vm-1"           # VM name
  vm_type      = "e2-micro"      # VM type
  network_name = "default"        # Network name for the Vm
  vm_zone      = "europe-west6-a" # Zone
}