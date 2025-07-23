output "instance_id" {
  description = "ID of the VSI."
  value       = ibm_is_instance.this.id
}

output "primary_ip" {
  description = "Primary private IPv4 address."
  value       = ibm_is_instance.this.primary_network_interface[0].primary_ip[0].address
}

output "floating_ip" {
  description = "Floating IP address (if allocated)."
  value       = try(ibm_is_floating_ip.fip[0].address, null)
}

output "private_key_pem" {
  description = "Generated private key PEM – handle securely."
  value       = try(tls_private_key.generated[0].private_key_pem, null)
  sensitive   = true
}

