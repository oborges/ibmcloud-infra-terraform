output "instance_id" {
  description = "GUID of the Db2 Warehouse instance."
  value       = ibm_resource_instance.db2wh.guid
}

output "dashboard_url" {
  description = "IBM Cloud dashboard URL for the instance."
  value       = ibm_resource_instance.db2wh.dashboard_url
}

