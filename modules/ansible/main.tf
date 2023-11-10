# Resource to create a delay of 60 seconds before executing subsequent resources.
resource "time_sleep" "wait_60_seconds" {
  create_duration = "60s" # Duration of the sleep, set to 60 seconds.
}

# Null resource used to trigger the Ansible playbook execution using local-exec provisioner.
resource "null_resource" "ansible_provisioner" {
  # Local-exec provisioner to run Ansible playbook via a shell command.
  provisioner "local-exec" {
    command = "ansible-playbook -i ${var.public_ip}, ${local.ansible_extra_vars_command} ${var.path_to_script}"
    # Command to run the Ansible playbook with dynamic IP, extra variables, and playbook path.
  }

  # Ensures the execution occurs after the 60-second delay.
  depends_on = [time_sleep.wait_60_seconds]
}