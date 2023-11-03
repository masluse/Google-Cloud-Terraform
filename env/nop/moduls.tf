module "sa1" {
  source       = "../../modules/service-account"
  account_id   = local.sa1_account_id
  display_name = local.sa1_display_name
  project_id   = local.project_id
}

module "dp1" {
  source         = "../../modules/disk-policy"
  project_id     = local.project_id
  region         = local.region
  name           = local.dp1_name
  description    = local.dp1_description
  start_time     = local.dp1_start_time
  retention_days = local.dp1_retention_days
  days_in_cycle  = local.dp1_days_in_cycle
}


module "vm1" {
  source                = "../../modules/virtual-machine"
  project_id            = local.project_id
  name                  = local.vm1_name
  type                  = local.vm1_type
  zone                  = local.zone
  network_name          = local.vm1_network_name
  disk_size             = local.vm1_disk_size
  image                 = local.vm1_image
  backup_policy         = module.dp1.snapshot_schedule_id
  service_account_email = module.sa1.service_account_email
}

module "disk1" {
  source        = "../../modules/disks"
  project_id    = local.project_id
  zone          = local.zone
  disk_name     = local.disk1_name
  disk_type     = local.disk1_type
  disk_size     = local.disk1_size
  backup_policy = module.dp1.snapshot_schedule_id
  instance_id   = module.vm1.compute_instance_id
}

module "disk2" {
  source        = "../../modules/disks"
  project_id    = local.project_id
  zone          = local.zone
  disk_name     = local.disk2_name
  disk_type     = local.disk2_type
  disk_size     = local.disk2_size
  backup_policy = module.dp1.snapshot_schedule_id
  instance_id   = module.vm1.compute_instance_id
}