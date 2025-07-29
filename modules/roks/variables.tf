###############
#  Variables  #
###############

variable "region" {
  description = "IBM Cloud region (default us-south)."
  type        = string
  default     = "us-south"
}

variable "vpc_name" {
  description = "Name of the existing VPC."
  type        = string
}

variable "cluster_name" {
  description = "OpenShift cluster name."
  type        = string
}

variable "kube_version" {
  description = "OpenShift version string, e.g. 4.15_openshift. Empty = latest GA."
  type        = string
  default     = ""
}

variable "worker_flavor" {
  description = "Worker node flavor (e.g. bx2.4x16)."
  type        = string
  default     = "bx2.4x16"
}

variable "workers_per_zone" {
  description = "Number of workers per zone."
  type        = number
  default     = 3
}

variable "zones" {
  description = "Set of zones for the worker pool."
  type        = set(string)
  default     = ["us-south-1", "us-south-2", "us-south-3"]
}

variable "subnet_ids" {
  description = "Map zone => subnet ID (must cover every zone)."
  type        = map(string)
}

variable "tags" {
  description = "Tags to apply to the cluster."
  type        = list(string)
  default     = []
}


##COS for backup
########################################################
# Optional automatic COS
########################################################
variable "create_cos" {
  description = "If true, create a new Standard Cloud Object Storage instance for the OpenShift registry"
  type        = bool
  default     = false
}

variable "cos_name" {
  description = "Name for the new COS instance (ignored if create_cos = false)"
  type        = string
  default     = "roks-registry-cos"
}

variable "cos_resource_group_id" {
  description = "Resource‑group ID for the COS instance (defaults to cluster RG)"
  type        = string
  default     = ""
}

# Still allow manual override
variable "cos_instance_crn" {
  description = "If provided, use this COS instance CRN instead of creating"
  type        = string
  default     = ""
}
