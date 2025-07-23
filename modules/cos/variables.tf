variable "instance_name" {
  description = "Name of the Cloud Object Storage instance."
  type        = string
}

variable "resource_group" {
  description = "Resource group name."
  type        = string
  default     = "Default"
}

variable "location" {
  description = "COS location (e.g. 'us-south' for single‑site, 'global' for cross‑region)."
  type        = string
  default     = "us-south"
}

variable "plan" {
  description = "Service plan: lite, standard, or enterprise."
  type        = string
  default     = "standard"
}

variable "tags" {
  description = "Optional resource tags."
  type        = list(string)
  default     = []
}

