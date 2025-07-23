############################################
# Terraform & providers                    #
############################################
terraform {
  required_version = ">= 1.5"

  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = ">= 1.12.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.1"
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
# Strong admin password generator          #
############################################
resource "random_password" "admin_pwd" {
  length           = 20
  special          = true
  override_special = "!#$%&*+-=?@^"
}

############################################
# EDB service instance                     #
############################################
resource "ibm_database" "edb" {
  name              = var.instance_name
  service           = "databases-for-enterprisedb"
  plan              = var.plan                       # standard / enterprise / platinum
  location          = var.region                     # default us-south
  resource_group_id = data.ibm_resource_group.rg.id

  service_endpoints = var.service_endpoints          # public-and-private / private
  adminpassword     = random_password.admin_pwd.result
  version           = var.major_version              # e.g. 14

  tags = var.tags
}

