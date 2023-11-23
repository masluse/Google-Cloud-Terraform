## Requirements

No requirements.

## Providers

The following providers are used by this module:

- <a name="provider_google"></a> [google](#provider\_google)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [google_compute_attached_disk.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_attached_disk) (resource)
- [google_compute_disk.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_disk) (resource)
- [google_compute_disk_resource_policy_attachment.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_disk_resource_policy_attachment) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_device_name"></a> [device\_name](#input\_device\_name)

Description: Name of disk

Type: `string`

### <a name="input_disk_name"></a> [disk\_name](#input\_disk\_name)

Description: Name of disk

Type: `string`

### <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size)

Description: Size of the disk

Type: `number`

### <a name="input_disk_type"></a> [disk\_type](#input\_disk\_type)

Description: Type of the disk

Type: `string`

### <a name="input_project_id"></a> [project\_id](#input\_project\_id)

Description: Project ID

Type: `string`

### <a name="input_zone"></a> [zone](#input\_zone)

Description: Zone

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_backup_policy"></a> [backup\_policy](#input\_backup\_policy)

Description: Backup policy for the disk

Type: `string`

Default: `""`

### <a name="input_instance_id"></a> [instance\_id](#input\_instance\_id)

Description: Virtual Machine instance ID

Type: `string`

Default: `""`

## Outputs

The following outputs are exported:

### <a name="output_google_compute_attached_disk"></a> [google\_compute\_attached\_disk](#output\_google\_compute\_attached\_disk)

Description: n/a

### <a name="output_google_compute_disk"></a> [google\_compute\_disk](#output\_google\_compute\_disk)

Description: n/a

### <a name="output_google_compute_disk_resource_policy_attachment"></a> [google\_compute\_disk\_resource\_policy\_attachment](#output\_google\_compute\_disk\_resource\_policy\_attachment)

Description: n/a
