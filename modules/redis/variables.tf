variable "instance_name" {
  description = "Name of the Redis service instance."
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
  description = "Service plan (standard, enterprise, platinum)."
  type        = string
  default     = "standard"
}

variable "major_version" {
  description = "Redis major version."
  type        = string
  default     = "7"
}

variable "service_endpoints" {
  description = "Network exposure: public-and-private or private."
  type        = string
  default     = "public-and-private"
}

variable "tags" {
  description = "Optional resource tags."
  type        = list(string)
  default     = []
}

