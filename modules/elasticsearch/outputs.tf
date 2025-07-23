output "instance_id" {
  description = "GUID of the Elasticsearch instance."
  value       = ibm_database.es.id
}

output "admin_password" {
  description = "Generated admin password."
  value       = random_password.admin_pwd.result
  sensitive   = true
}

