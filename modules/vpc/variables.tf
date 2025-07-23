###############
#  Variables  #
###############
variable "vpc_name" {
  description = "Name of the VPC."
  type        = string
}

variable "region" {
  description = "IBM Cloud region (e.g. br-sao, us-south)."
  type        = string
}

variable "zones" {
  description = "List of availability zones inside the region."
  type        = list(string)
  validation {
    condition     = length(var.zones) >= 2
    error_message = "Provide at least two zones for HA."
  }
}

variable "resource_group" {
  description = "Name of the resource group."
  type        = string
  default     = "Default"
}

variable "vpc_cidr" {
  description = "Base CIDR block for the VPC (must be /16 or /17)."
  type        = string
  default     = "10.10.0.0/16"
  validation {
    condition     = cidrsubnet(var.vpc_cidr, 8, 0) != ""
    error_message = "vpc_cidr must be a valid IPv4 CIDR (e.g. 10.10.0.0/16)."
  }
}

variable "tags" {
  description = "Extra tags to attach to all resources."
  type        = list(string)
  default     = []
}

variable "environment" {
  description = "Logical environment name (dev, stage, prod)."
  type        = string
  default     = "dev"
}

