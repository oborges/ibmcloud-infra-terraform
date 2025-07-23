variable "region" {
  description = "IBM Cloud region (default us-south)."
  type        = string
  default     = "us-south"
}

variable "zone" {
  description = "Availability zone (us-south-1, us-south-2, or us-south-3)."
  type        = string
  default     = "us-south-1"
  validation {
    condition     = contains(["us-south-1", "us-south-2", "us-south-3"], var.zone)
    error_message = "Zone must be us-south-1, us-south-2, or us-south-3."
  }
}

# --- VPC selection -----------------------------------------------------------
variable "vpc_id" {
  description = "ID of an existing VPC (takes precedence over vpc_name)."
  type        = string
  default     = ""
}

variable "vpc_name" {
  description = "Name of an existing VPC (ignored if vpc_id is set)."
  type        = string
}

# ---------------------------------------------------------------------------

variable "subnet_id" {
  description = "ID of an existing subnet in the chosen zone."
  type        = string
}

variable "image_name" {
  description = "Exact public image name for RHEL 8."
  type        = string
  default     = "ibm-redhat-9-6-minimal-amd64-2"
}

variable "instance_name" {
  description = "VSI name."
  type        = string
}

variable "profile" {
  description = "Compute profile (e.g. bx2-2x8, bx2-4x16)."
  type        = string
  default     = "bx2-2x8"
}

variable "existing_ssh_key_name" {
  description = "Cloud SSH key name to reuse; leave blank to auto‑generate."
  type        = string
  default     = ""
}

variable "attach_floating_ip" {
  description = "Whether to allocate a floating IP."
  type        = bool
  default     = true
}

variable "allowed_ssh_cidr" {
  description = "CIDR allowed for SSH."
  type        = string
  default     = "0.0.0.0/0"
}

variable "tags" {
  description = "Extra resource tags."
  type        = list(string)
  default     = []
}

variable "environment" {
  description = "Environment label (dev, stage, prod)."
  type        = string
  default     = "dev"
}

