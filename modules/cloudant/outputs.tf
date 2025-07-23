output "instance_id" {
  description = "GUID of the Cloudant instance."
  value       = ibm_resource_instance.cloudant.guid
}

output "dashboard_url" {
  description = "IBM Cloud dashboard URL for the instance."
  value       = ibm_resource_instance.cloudant.dashboard_url
}

