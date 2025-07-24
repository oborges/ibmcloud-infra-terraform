############################
# Workspace parameters     #
############################
variable "workspace_id" {
  description = "Existing PowerVS workspace ID (skip creation if set)."
  type        = string
  default     = ""
}

variable "workspace_name" {
  description = "Workspace name when a new workspace is created."
  type        = string
  default     = "powervs-ws"
}

variable "workspace_plan" {
  description = "Workspace billing plan: hourly or monthly."
  type        = string
  default     = "hourly"
}

variable "resource_group" {
  description = "Resource group for the workspace."
  type        = string
  default     = "Default"
}

variable "region" {
  description = "IBM Cloud region (e.g. us-south)."
  type        = string
  default     = "us-south"
}

############################
# Subnet parameters        #
############################
variable "subnet_id" {
  description = "Existing subnet ID. Leave empty to create a new private subnet."
  type        = string
  default     = ""
}

variable "subnet_name" {
  description = "Subnet name when creating a new subnet."
  type        = string
  default     = "pvs-subnet"
}

variable "subnet_cidr" {
  description = "CIDR block for the new subnet."
  type        = string
  default     = "10.0.0.0/24"
}

############################
# SSH key parameters       #
############################
variable "ssh_key_name" {
  description = "Existing SSH key name in the workspace. Leave empty to upload a new key."
  type        = string
  default     = ""
}

variable "public_key_path" {
  description = "Path to the public key file used when uploading a new key."
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "generated_key_name" {
  description = "Name assigned to the newly uploaded SSH key."
  type        = string
  default     = "pvs-auto-key"
}

############################
# VM parameters            #
############################
variable "instance_name" {
  description = "Name of the PowerVS VM."
  type        = string
  default     = "pvs-vm"
}

variable "image_name" {
  description = "Image name to search (default = AIX 7300-03-00)."
  type        = string
  default     = "AIX 7300-03-00"
}

