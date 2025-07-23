output "instance_id" {
  description = "GUID of the PostgreSQL instance."
  value       = ibm_database.postgres.id
}

output "admin_password" {
  description = "Generated admin password."
  value       = random_password.admin_pwd.result
  sensitive   = true
}

