## Requirements

No requirements.

## Providers

The following providers are used by this module:

- <a name="provider_google"></a> [google](#provider\_google)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [google_compute_resource_policy.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_resource_policy) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_days_in_cycle"></a> [days\_in\_cycle](#input\_days\_in\_cycle)

Description: Days in cycle

Type: `any`

### <a name="input_name"></a> [name](#input\_name)

Description: The name of the snapshot schedule

Type: `any`

### <a name="input_project_id"></a> [project\_id](#input\_project\_id)

Description: The project ID where the snapshot schedule will be created

Type: `any`

### <a name="input_region"></a> [region](#input\_region)

Description: The region where the snapshot schedule will be created

Type: `any`

### <a name="input_retention_days"></a> [retention\_days](#input\_retention\_days)

Description: Backup retention days

Type: `any`

### <a name="input_start_time"></a> [start\_time](#input\_start\_time)

Description: The start time of the Backup

Type: `any`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_description"></a> [description](#input\_description)

Description: The description of the snapshot schedule

Type: `string`

Default: `"Daily snapshots at midnight, retained for 10 days"`

## Outputs

The following outputs are exported:

### <a name="output_google_compute_resource_policy"></a> [google\_compute\_resource\_policy](#output\_google\_compute\_resource\_policy)

Description: n/a
