# Google-Cloud-Terraform
## Overview
This project utilizes Terraform for configuring and deploying a suite of cloud infrastructure resources on Google Cloud Platform. It streamlines the creation of service accounts, disk policies, virtual machines (VMs), and persistent disks, ensuring efficient and organized cloud resource management.
## Modules at a Glance
- ansible: Initializes an Ansible playbook for automated configuration management.
- disk-policy: Establishes snapshot policies for data protection and recovery.
- disks: Manages the creation and association of persistent disks with VMs and snapshot policies.
- service-account: Sets up service accounts for secure, scoped access to cloud resources.
- virtual-machine: Deploys VMs, integrating them with service accounts and backup policies for optimized operation.
## Prerequisites
Terraform (version 1.6 or newer)
Google Cloud access credentials (via cloud provider CLI)
An initialized Google Cloud project where resources will be deployed
## Module Usage
### ansible/disk_add

Defines an Ansible module for adding disks, linking it to a specific VM, and setting up associated configurations. It ensures the module is executed only after the necessary VM and disk provisioning.
```
module "ansible1" {
  source         = "../../modules/ansible"               # Path to the Ansible module.
  path_to_script = "../../scripts/ansible/disk_add.yaml" # Path to the Ansible playbook.
  public_ip      = local.vm1_name                        # Public IP of the provisioned VM.

  # Additional variables for Ansible.
  ansible_extra_vars = {
    disk_name = local.disk1_name,
    mnt_name  = local.mnt_name1
  }

  # Ensures that Ansible is executed only after VM and disk provisioning.
  depends_on = [module.vm1, module.disk1]
}
```
### disk-policy

This module creates a disk backup policy, defining various parameters such as project ID, region, policy name, description, and the backup schedule.
```
# This module block creates a disk backup policy using a specified module.
module "dp1" {
  source         = "../../modules/disk-policy" # Specifies the relative path to the disk policy module.
  project_id     = local.project_id            # Sets the Google Cloud project ID where the policy will be applied.
  region         = local.region                # Defines the region for applying the disk policy.
  name           = local.dp1_name              # Assigns a name to the backup policy.
  description    = local.dp1_description       # Provides a description for the backup policy.
  start_time     = local.dp1_start_time        # Configures the start time for the backup policy.
  retention_days = local.dp1_retention_days    # Sets the number of days for retaining snapshots.
  days_in_cycle  = local.dp1_days_in_cycle     # Defines the frequency of the backup cycle in days.
}
```
### disks

Creates a persistent disk in a specified zone, assigning it a name, type, size, and linking it to both a VM instance and a backup policy. Dependencies are managed to ensure correct order of resource creation.
```
# Module block for creating a persistent disk with specified properties using the 'disks' module.
module "disk1" {
  source        = "../../modules/disks"             # Path to the disks module.
  project_id    = local.project_id                  # Google Cloud project ID for disk creation.
  zone          = local.zone                        # Zone where the disk will be deployed.
  disk_name     = local.disk1_name                  # Name assigned to the disk.
  disk_type     = local.disk1_type                  # Type of the disk (e.g., pd-standard).
  disk_size     = local.disk1_size                  # Size of the disk in GB.
  backup_policy = module.dp1.snapshot_schedule.name # Backup policy to be associated with the disk.
  instance_id   = module.vm1.compute_instance.name  # ID of the VM instance to which the disk will be attached.

  # Ensures that the disk is created only after the specified modules are provisioned.
  depends_on = [
    module.vm1, module.dp1
  ]
}
```
### service-account

Facilitates the creation of a new service account, providing details like account ID, display name, and the project ID where it will be created.
```
# This block declares a Terraform module to create a new service account.
module "sa1" {
  source       = "../../modules/service-account" # Specifies the relative path to the service account module.
  account_id   = local.sa1_account_id            # Sets the service account ID using a value from local variables.
  display_name = local.sa1_display_name          # Assigns a human-readable name to the service account.
  project_id   = local.project_id                # Defines the Google Cloud project ID where the service account will be created.
}
```

### virtual-machine

This module block is responsible for creating a VM instance with specified properties such as project ID, name, type, zone, network, and disk size. It also associates the VM with a backup policy and a service account.
```
# Module block for creating a virtual machine (VM) instance with specified properties.
module "vm1" {
  source                = "../../modules/virtual-machine"   # Path to the virtual machine module.
  project_id            = local.project_id                  # ID of the Google Cloud project where the VM is created.
  name                  = local.vm1_name                    # Name assigned to the VM instance.
  type                  = local.vm1_type                    # Machine type for the VM, defining CPU and memory.
  zone                  = local.zone                        # Zone where the VM will be deployed.
  network_name          = local.vm1_network_name            # Network to which the VM will be connected.
  disk_size             = local.vm1_disk_size               # Size of the VM's boot disk.
  image                 = local.vm1_image                   # Boot image used for the VM.
  backup_policy         = module.dp1.snapshot_schedule.name # Backup policy associated with the VM.
  service_account_email = module.sa1.service_account.email  # Service account email associated with the VM.

  # Ensures that the VM is created only after the specified modules are successfully provisioned.
  depends_on = [
    module.dp1, module.sa1
  ]
}
```
## Configuring Ansible for gcloud SSH
### env/nop/ansible.cfg

Configures Ansible for SSH connections, privilege escalation, and execution strategy. It's tailored to enable efficient and secure management of cloud resources.
```
[ssh_connection]
pipelining = True
ssh_executable = misc/gssh.sh
ssh_args =
transfer_method = piped

[privilege_escalation]
become = True
become_method = sudo

[defaults]
interpreter_python = /usr/bin/python3
# Somehow important to enable parallel execution...
strategy = free
```
### env/nop/misc/gssh.sh

A custom script to enhance Ansible's SSH capabilities, especially for Google Cloud environments. It specifies command execution patterns, SSH connection settings, and integrates with gcloud compute ssh for optimized operations.
```
#!/bin/bash

# ansible/ansible/lib/ansible/plugins/connection/ssh.py
# exec_command(self, cmd, in_data=None, sudoable=True) calls _build_command(self, binary, *other_args) as:
#   args = (ssh_executable, self.host, cmd)
#   cmd = self._build_command(*args)
# So "host" is next to the last, cmd is the last argument of ssh command.

host="${@: -2: 1}"
cmd="${@: -1: 1}"

# ControlMaster=auto & ControlPath=... speedup Ansible execution 2 times.
socket="/tmp/ansible-ssh-${host}-22-iap"

gcloud_args="
--tunnel-through-iap
--zone=europe-west6-a
--quiet
--no-user-output-enabled
--
-C
-T
-o ControlMaster=auto
-o ControlPersist=20
-o PreferredAuthentications=publickey
-o KbdInteractiveAuthentication=no
-o PasswordAuthentication=no
-o ConnectTimeout=20"

exec gcloud compute ssh "$host" $gcloud_args -o ControlPath="$socket" "$cmd"
```
