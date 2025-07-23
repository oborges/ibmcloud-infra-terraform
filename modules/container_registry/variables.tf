variable "registry_name" {
  description = "Name of the Container Registry instance."
  type        = string
}

variable "resource_group" {
  description = "Resource group name."
  type        = string
  default     = "Default"
}

variable "location" {
  description = "Registry location (default: global)."
  type        = string
  default     = "global"
}

variable "plan" {
  description = "Service plan (standard / graduated‑tier)."
  type        = string
  default     = "standard"
}

