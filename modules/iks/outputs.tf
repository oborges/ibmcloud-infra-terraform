output "cluster_id" {
  description = "ID of the IKS cluster."
  value       = ibm_container_vpc_cluster.this.id
}

output "master_endpoint" {
  description = "Kubernetes API server endpoint."
  value       = ibm_container_vpc_cluster.this.master_url
}

output "resource_group_id" {
  description = "Resource group ID."
  value       = ibm_container_vpc_cluster.this.resource_group_id
}

