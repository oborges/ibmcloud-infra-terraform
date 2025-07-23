variable "volume_name" {
  description = "Name of the Block Storage volume."
  type        = string
}

variable "resource_group" {
  description = "Resource group name."
  type        = string
  default     = "Default"
}

variable "profile" {
  description = "Volume profile (general-purpose, 10iops-tier, custom-iops)."
  type        = string
  default     = "general-purpose"
}

variable "capacity" {
  description = "Volume capacity in GiB."
  type        = number
  default     = 100
}

variable "iops" {
  description = "Custom IOPS (required for custom-iops profile)."
  type        = number
  default     = 0
}

variable "zone" {
  description = "Zone where the volume will be created (e.g. us-south-1)."
  type        = string
  default     = "us-south-1"
}

variable "encryption_key_id" {
  description = "CRK GUID for customer-managed encryption (optional)."
  type        = string
  default     = ""
}

variable "tags" {
  description = "Optional resource tags."
  type        = list(string)
  default     = []
}

