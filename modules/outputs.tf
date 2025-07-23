output "instance_id" {
  description = "GUID of the EDB instance."
  value       = ibm_database.edb.id
}

output "admin_password" {
  description = "Generated admin password."
  value       = random_password.admin_pwd.result
  sensitive   = true
}

