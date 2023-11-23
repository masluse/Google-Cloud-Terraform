## Requirements

No requirements.

## Providers

The following providers are used by this module:

- <a name="provider_null"></a> [null](#provider\_null)

- <a name="provider_time"></a> [time](#provider\_time)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [null_resource.ansible_provisioner](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) (resource)
- [time_sleep.wait_40_seconds](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_path_to_script"></a> [path\_to\_script](#input\_path\_to\_script)

Description: The file path to the Ansible playbook

Type: `string`

### <a name="input_vm_name"></a> [vm\_name](#input\_vm\_name)

Description: The public IP address of the target machine for Ansible

Type: `string`

### <a name="input_vm_zone"></a> [vm\_zone](#input\_vm\_zone)

Description: Zone of the vm that Ansible should connect to

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_ansible_extra_vars"></a> [ansible\_extra\_vars](#input\_ansible\_extra\_vars)

Description: Extra variables to pass to the Ansible playbook

Type: `map(string)`

Default: `{}`

## Outputs

No outputs.
