module "service_account" {
  source       = "../../modules/service-account"
  account_id   = local.account_id
  display_name = local.display_name
  project_id   = local.project_id
}

module "backup_policy" {
  source            = "../../modules/backup-policy"
  project_id        = local.project_id
  bp_name           = local.bp_name
  bp_description    = local.bp_description
  region            = local.region
  bp_start_time     = local.bp_start_time
  bp_retention_days = local.bp_retention_days
}


module "ubuntu_vm" {
  source                = "../../modules/ubuntu-vm"
  project_id            = local.project_id
  vm_name               = local.vm_name
  vm_type               = local.vm_type
  vm_zone               = local.vm_zone
  network_name          = local.network_name
  backup_policy         = module.backup_policy.snapshot_schedule_id
  service_account_email = module.service_account.service_account_email
}

module "more-disks" {
  source                = "../../modules/more-disks"
  disk_name
  disk_type
  vm_zone
  disk_size
  project_id
  backup_policy
  }