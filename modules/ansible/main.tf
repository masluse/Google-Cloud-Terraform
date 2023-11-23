# Resource to create a delay of 40 seconds before executing subsequent resources.
resource "time_sleep" "wait_40_seconds" {
  create_duration = "40s" # Duration of the sleep, set to 40 seconds.
}

# Null resource used to trigger the Ansible playbook execution using local-exec provisioner.
resource "null_resource" "ansible_provisioner" {
  # Local-exec provisioner to run Ansible playbook via a shell command.
  provisioner "local-exec" {
    environment = {
      GCLOUD_ARGS = var.vm_zone
    }
    command = "ansible-playbook -i ${var.vm_name}, ${local.ansible_extra_vars_command} ${var.path_to_script}"
    # Command to run the Ansible playbook with dynamic IP, extra variables, and playbook path.
  }

  # Ensures the execution occurs after the 40-second delay.
  depends_on = [time_sleep.wait_40_seconds]

  # Trigger für die Neuausführung hinzufügen, basierend auf den Werten von ansible_extra_vars
  triggers = {
    ansible_vars_hash = md5(jsonencode({
      ansible_extra_vars = local.ansible_extra_vars_command,
      vm_name            = var.vm_name
    }))
  }
}