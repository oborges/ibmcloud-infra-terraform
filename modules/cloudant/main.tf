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
# Cloudant service instance                #
############################################
resource "ibm_resource_instance" "cloudant" {
  name              = var.instance_name
  service           = "cloudant-nosql-db"
  plan              = var.plan               # lite / standard
  location          = var.region             # e.g. us-south
  resource_group_id = data.ibm_resource_group.rg.id
  tags              = var.tags
}

