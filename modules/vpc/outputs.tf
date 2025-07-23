output "vpc_id" {
  description = "ID of the VPC."
  value       = ibm_is_vpc.this.id
}

output "subnet_ids" {
  description = "Subnet IDs keyed by zone."
  value       = { for z, s in ibm_is_subnet.subnet : z => s.id }
}

output "public_gateway_ids" {
  description = "Public Gateway IDs keyed by zone."
  value       = { for z, pg in ibm_is_public_gateway.pg : z => pg.id }
}

