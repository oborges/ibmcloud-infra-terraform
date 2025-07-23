###############
#  Variables  #
###############

variable "region" {
  description = "IBM Cloud region (provider uses it; default us-south)."
  type        = string
  default     = "us-south"
}

variable "zones" {
  description = "Availability zones for multi‑AZ VPC."
  type        = list(string)
  default     = ["us-south-1", "us-south-2", "us-south-3"]

  validation {
    condition     = length(var.zones) >= 2
    error_message = "Provide at least two zones for high availability."
  }
}

variable "vpc_name" {
  description = "Name of the VPC."
  type        = string
}

variable "resource_group" {
  description = "IBM Cloud resource‑group name."
  type        = string
  default     = "Default"
}

variable "vpc_cidr" {
  description = "Base CIDR (e.g. 10.10.0.0/16). Must be /16 or /17."
  type        = string
  default     = "10.10.0.0/16"

  validation {
    condition     = cidrsubnet(var.vpc_cidr, 8, 0) != ""
    error_message = "vpc_cidr must be a valid IPv4 CIDR."
  }
}

variable "tags" {
  description = "Extra resource tags."
  type        = list(string)
  default     = []
}

variable "environment" {
  description = "Environment label (dev/stage/prod)."
  type        = string
  default     = "dev"
}

