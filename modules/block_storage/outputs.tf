output "volume_id" {
  description = "ID of the Block Storage volume."
  value       = ibm_is_volume.volume.id
}

output "volume_arn" {
  description = "CRN of the volume."
  value       = ibm_is_volume.volume.crn
}

