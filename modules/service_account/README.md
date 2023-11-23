## Requirements

No requirements.

## Providers

The following providers are used by this module:

- <a name="provider_google"></a> [google](#provider\_google)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [google_service_account.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_account_id"></a> [account\_id](#input\_account\_id)

Description: The ID of the service account.

Type: `string`

### <a name="input_display_name"></a> [display\_name](#input\_display\_name)

Description: The display name of the service account.

Type: `string`

### <a name="input_project_id"></a> [project\_id](#input\_project\_id)

Description: The project that the service account will belong to.

Type: `string`

## Optional Inputs

No optional inputs.

## Outputs

The following outputs are exported:

### <a name="output_google_service_account"></a> [google\_service\_account](#output\_google\_service\_account)

Description: n/a
