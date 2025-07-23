output "instance_id" {
  description = "GUID of the Db2 on Cloud instance."
  value       = ibm_resource_instance.db2.guid
}

output "dashboard_url" {
  description = "IBM Cloud dashboard URL for the instance."
  value       = ibm_resource_instance.db2.dashboard_url
}

