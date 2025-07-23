output "instance_id" {
  description = "GUID of the Redis instance."
  value       = ibm_database.redis.id
}

output "admin_password" {
  description = "Generated admin password."
  value       = random_password.admin_pwd.result
  sensitive   = true
}

