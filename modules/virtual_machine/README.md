## Requirements

No requirements.

## Providers

The following providers are used by this module:

- <a name="provider_google"></a> [google](#provider\_google)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [google_compute_disk_resource_policy_attachment.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_disk_resource_policy_attachment) (resource)
- [google_compute_instance.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size)

Description: Disk size of disk

Type: `string`

### <a name="input_image"></a> [image](#input\_image)

Description: Image of Virtual Machine

Type: `string`

### <a name="input_name"></a> [name](#input\_name)

Description: The name of the VM instance to create

Type: `string`

### <a name="input_network_name"></a> [network\_name](#input\_network\_name)

Description: The name of the VPC network to attach the VM

Type: `string`

### <a name="input_project_id"></a> [project\_id](#input\_project\_id)

Description: The project ID to host the VM in

Type: `string`

### <a name="input_service_account_email"></a> [service\_account\_email](#input\_service\_account\_email)

Description: The service account email attached to the VM

Type: `string`

### <a name="input_type"></a> [type](#input\_type)

Description: Virtual Machine type

Type: `string`

### <a name="input_zone"></a> [zone](#input\_zone)

Description: Virtual Machine zone

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_backup_policy"></a> [backup\_policy](#input\_backup\_policy)

Description: Backup policy for the disk

Type: `string`

Default: `""`

## Outputs

The following outputs are exported:

### <a name="output_google_compute_disk_resource_policy_attachment"></a> [google\_compute\_disk\_resource\_policy\_attachment](#output\_google\_compute\_disk\_resource\_policy\_attachment)

Description: n/a

### <a name="output_google_compute_instance"></a> [google\_compute\_instance](#output\_google\_compute\_instance)

Description: n/a
