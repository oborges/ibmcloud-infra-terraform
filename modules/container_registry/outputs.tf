output "registry_id" {
  description = "GUID of the Container Registry instance."
  value       = ibm_resource_instance.registry.guid
}

output "registry_server" {
  description = "Docker registry endpoint."
  value       = local.registry_server
}

output "location" {
  description = "Registry location."
  value       = var.location
}

