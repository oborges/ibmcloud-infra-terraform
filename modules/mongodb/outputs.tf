output "instance_id" {
  description = "GUID of the MongoDB instance."
  value       = ibm_database.mongodb.id
}

output "admin_password" {
  description = "Generated admin password."
  value       = random_password.admin_pwd.result
  sensitive   = true
}

