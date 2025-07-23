############################################
# Terraform & provider                     #
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
# Cloud Object Storage instance            #
############################################
resource "ibm_resource_instance" "cos" {
  name              = var.instance_name
  service           = "cloud-object-storage"
  plan              = var.plan        # lite / standard / enterprise
  location          = var.location    # e.g. us-south or global
  resource_group_id = data.ibm_resource_group.rg.id
  tags              = var.tags
}

