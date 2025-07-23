variable "instance_name" {
  description = "Name of the Db2 Warehouse instance."
  type        = string
}

variable "resource_group" {
  description = "Resource group name."
  type        = string
  default     = "Default"
}

variable "region" {
  description = "IBM Cloud region."
  type        = string
  default     = "us-south"
}

variable "plan" {
  description = "Service plan (flex, enterprise)."
  type        = string
  default     = "flex"
}

variable "tags" {
  description = "Optional resource tags."
  type        = list(string)
  default     = []
}

