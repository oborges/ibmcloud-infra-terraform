###############
#  Variables  #
###############

variable "region" {
  description = "IBM Cloud region (default us-south)."
  type        = string
  default     = "us-south"
}

variable "vpc_name" {
  description = "Name of the VPC where the cluster will run."
  type        = string
}

variable "cluster_name" {
  description = "Cluster name."
  type        = string
}

variable "kube_version" {
  description = "Exact Kubernetes version (e.g. 1.30.0). Empty = latest."
  type        = string
  default     = ""
}

variable "worker_flavor" {
  description = "Worker node flavor (e.g. bx2.4x16)."
  type        = string
  default     = "bx2.4x16"
}

variable "workers_per_zone" {
  description = "Number of workers per subnet/zone."
  type        = number
  default     = 2
}

variable "zones" {
  description = "Set of zones for the worker pool."
  type        = set(string)
  default     = ["us-south-1", "us-south-2", "us-south-3"]
}

variable "subnet_ids" {
  description = "Map zone => subnet ID (must cover every zone in var.zones)."
  type        = map(string)
}

variable "tags" {
  description = "Tags to apply to the cluster."
  type        = list(string)
  default     = []
}

