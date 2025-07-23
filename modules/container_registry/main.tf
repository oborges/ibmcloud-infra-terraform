############################################
# Terraform & provider requirements        #
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
# Container Registry instance              #
############################################
resource "ibm_resource_instance" "registry" {
  name              = var.registry_name
  service           = "container-registry"
  plan              = var.plan
  location          = var.location         # default "global"
  resource_group_id = data.ibm_resource_group.rg.id
}

############################################
# Local helper values                      #
############################################
locals {
  # Registry server domain: "icr.io" for global, "<region>.icr.io" otherwise
  registry_server = var.location == "global" ? "icr.io" : "${var.location}.icr.io"
}

