output "workspace_id" {
  description = "ID of the PowerVS workspace."
  value       = local.workspace_id
}

output "instance_id" {
  description = "ID of the Power Virtual Server instance."
  value       = ibm_pi_instance.vm.id
}

