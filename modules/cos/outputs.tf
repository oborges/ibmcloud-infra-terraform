output "instance_id" {
  description = "GUID of the Cloud Object Storage instance."
  value       = ibm_resource_instance.cos.guid
}

output "dashboard_url" {
  description = "IBM Cloud dashboard URL for the COS instance."
  value       = ibm_resource_instance.cos.dashboard_url
}

