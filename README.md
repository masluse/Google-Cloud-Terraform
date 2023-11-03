﻿# Google-Cloud-Terraform
## Overview
This Terraform project consists of the configuration and deployment of cloud infrastructure resources. It includes the creation of service accounts, disk policies, virtual machines, and disks within a cloud project.
## Modules at a Glance
- service-account: Configures a service account.
- disk-policy: Defines a policy for disk snapshots.
- virtual-machine: Creates a virtual machine (VM) and assigns it a service account and backup policy.
- disks: Provisions a disk and associates it with the VM and snapshot policy.
## Requirements
Terraform installed (version 1.6 or higher)
Access credentials for the cloud environment (e.g., as environment variables or via cloud provider CLI)
An initialized cloud project to which the resources will be applied
## Usage
To use this project, you should first customize your local configurations to specify your project details, such as account_id, display_name, project_id, region, zone, etc.
1. Clone the project to your local directory:
  ```
  git clone https://github.com/masluse/Google-Cloud-Terraform
  cd ./Google-Cloud-Terraform/env/nop/
  ```
2. Initialize Terraform to download the necessary provider plugins:
  ```
  terraform init
  ```
3. Create a plan to review the changes to be applied:
  ```
  terraform plan
  ```
4. Apply the configuration to create the resources:
  ```
  terraform apply
  ```
## Usage of the Modules
1. service-account
  ```
  module "sa1" {
    source       = "../../modules/service-account"
    account_id   = local.sa1_account_id
    display_name = local.sa1_display_name
    project_id   = local.project_id
  }
  ```
2. disk-policy
```
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
```
3. virtual-machine
```
module "vm1" {
  source                = "../../modules/virtual-machine"
  project_id            = local.project_id
  name                  = local.vm1_name
  type                  = local.vm1_type
  zone                  = local.zone
  network_name          = local.vm1_network_name
  disk_size             = local.vm1_disk_size
  image                 = local.vm1_image
  service_account_email = module.sa1.service_account_email
  backup_policy         = module.dp1.snapshot_schedule_id # Optional
}
```
4. disks
```
module "disk1" {
  source        = "../../modules/disks"
  project_id    = local.project_id
  zone          = local.zone
  disk_name     = local.disk1_name
  disk_type     = local.disk1_type
  disk_size     = local.disk1_size
  backup_policy = module.dp1.snapshot_schedule_id # Optional
  instance_id   = module.vm1.compute_instance_id # Optional
}
```


