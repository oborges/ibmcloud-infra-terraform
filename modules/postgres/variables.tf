variable "instance_name" {
  description = "Name of the PostgreSQL service instance."
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
  description = "Service plan (standard, enterprise, enterprise-sharding, platinum)."
  type        = string
  default     = "standard"
}

variable "major_version" {
  description = "PostgreSQL major version."
  type        = string
  default     = "14"
}

variable "service_endpoints" {
  description = "Network exposure: public-and-private or private."
  type        = string
  default     = "public-and-private"
}

variable "admin_user" {
  description = "Database admin username."
  type        = string
  default     = "admin"
}

variable "tags" {
  description = "Optional resource tags."
  type        = list(string)
  default     = []
}

