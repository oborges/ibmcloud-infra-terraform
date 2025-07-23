############################################
# Terraform & required providers           #
############################################
terraform {
  required_version = ">= 1.5"

  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = ">= 1.12.0"
    }
  }
}

############################################
# Resource‑group lookup                    #
############################################
data "ibm_resource_group" "rg" {
  name = var.resource_group
}

############################################
# Block Storage volume                     #
############################################
resource "ibm_is_volume" "volume" {
  name           = var.volume_name
  profile        = var.profile  # general-purpose, 10iops-tier, etc.
  capacity       = var.capacity # GiB
  iops           = var.iops     # use only with custom profile
  zone           = var.zone     # e.g. us-south-1
  resource_group = data.ibm_resource_group.rg.id
  encryption_key = var.encryption_key_id # optional
  tags           = var.tags
}

