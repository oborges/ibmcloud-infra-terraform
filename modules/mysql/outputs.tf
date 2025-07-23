output "instance_id" {
  description = "GUID of the MySQL instance."
  value       = ibm_database.mysql.id
}

output "admin_password" {
  description = "Generated admin password."
  value       = random_password.admin_pwd.result
  sensitive   = true
}

