#################################################
#  Generic settings                             #
#################################################
variable "region" {
  description = "IBM Cloud region (default us-south)."
  type        = string
  default     = "us-south"
}

variable "resource_group" {
  description = "Resource group name."
  type        = string
  default     = "Default"
}

#################################################
#  Project settings                             #
#################################################
variable "project_name" {
  description = "Code Engine project name."
  type        = string
}

variable "project_create_if_missing" {
  description = "Create the project if it does not already exist?"
  type        = bool
  default     = true
}

#################################################
#  Application settings                         #
#################################################
variable "app_name" {
  description = "Application name."
  type        = string
}

variable "image" {
  description = "Container image. Default: demo hello‑world."
  type        = string
  default     = "icr.io/codeengine/helloworld"
}

variable "cpu" {
  description = "CPU per instance (vCPU)."
  type        = number
  default     = 0.125
}

variable "memory" {
  description = "Memory per instance (GiB)."
  type        = number
  default     = 0.25
}

variable "min_instances" {
  description = "Minimum running instances."
  type        = number
  default     = 0
}

variable "max_instances" {
  description = "Maximum running instances."
  type        = number
  default     = 5
}

variable "run_command" {
  description = "Command to start the container (optional)."
  type        = string
  default     = ""
}

variable "run_args" {
  description = "Arguments for the run command."
  type        = list(string)
  default     = []
}

variable "environment_vars" {
  description = "Map of environment variables for the container."
  type        = map(string)
  default     = {}
}

