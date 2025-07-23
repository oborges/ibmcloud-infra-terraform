variable "instance_name" {
  description = "Name of the Cloudant instance."
  type        = string
}

variable "resource_group" {
  description = "Resource group name."
  type        = string
  default     = "Default"
}

variable "region" {
  description = "IBM Cloud region for the instance."
  type        = string
  default     = "us-south"
}

variable "plan" {
  description = "Service plan: lite (free) or standard."
  type        = string
  default     = "standard"
}

variable "tags" {
  description = "Optional resource tags."
  type        = list(string)
  default     = []
}

