output "project_id" {
  description = "ID of the Code Engine project."
  value       = ibm_resource_instance.project.guid
}

output "app_id" {
  description = "ID of the Code Engine application."
  value       = ibm_code_engine_app.app.id
}

output "app_endpoint" {
  description = "Public HTTPS endpoint of the application."
  value       = ibm_code_engine_app.app.endpoint
}

