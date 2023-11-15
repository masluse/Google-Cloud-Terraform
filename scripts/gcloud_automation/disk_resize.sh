#!/bin/bash

# Define variables
vm_name="vm-1"
zone="europe-west6-a"
google_disk_name="migration"
os_disk_name="migration"
new_size="25GB"

# Path to script
script_path="../ansible/disk_resize.yaml"

# Resize disk without user confirmation
gcloud compute disks resize "$google_disk_name" --size="$new_size" --zone="$zone" --quiet

# Run Ansible playbook
export GCLOUD_ARGS="$zone"
ansible-playbook -i "$vm_name," -e "disk_name=$os_disk_name" "$script_path"
