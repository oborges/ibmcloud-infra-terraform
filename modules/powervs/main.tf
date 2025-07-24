############################################
# Terraform & IBM Cloud provider           #
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
# Resource group                           #
############################################
data "ibm_resource_group" "rg" {
  name = var.resource_group
}

############################################
# PowerVS workspace (create if missing)    #
############################################
resource "ibm_resource_instance" "workspace" {
  count             = var.workspace_id == "" ? 1 : 0
  name              = var.workspace_name
  service           = "power-iaas"
  plan              = var.workspace_plan               # hourly | monthly
  location          = var.region
  resource_group_id = data.ibm_resource_group.rg.id
}

locals {
  workspace_id = var.workspace_id != "" ? var.workspace_id : ibm_resource_instance.workspace[0].guid
}

############################################
# SSH key: reuse or upload new             #
############################################
data "ibm_pi_key" "existing" {
  count                = var.ssh_key_name != "" ? 1 : 0
  pi_cloud_instance_id = local.workspace_id
  pi_key_name          = var.ssh_key_name
}

resource "ibm_pi_key" "generated" {
  count                = var.ssh_key_name == "" ? 1 : 0
  pi_cloud_instance_id = local.workspace_id
  pi_key_name          = var.generated_key_name
  pi_ssh_key           = file(var.public_key_path)
}

locals {
  key_name = var.ssh_key_name != "" ? var.ssh_key_name : ibm_pi_key.generated[0].pi_key_name
}

############################################
# Subnet: create if missing                #
############################################
resource "ibm_pi_network" "subnet" {
  count                 = var.subnet_id == "" ? 1 : 0
  pi_cloud_instance_id  = local.workspace_id
  pi_network_name       = var.subnet_name
  pi_network_type       = "vlan"          # private VLAN
  pi_cidr               = var.subnet_cidr # e.g. 10.0.0.0/24
}

locals {
  subnet_id = var.subnet_id != "" ? var.subnet_id : ibm_pi_network.subnet[0].network_id
}

############################################
# Image lookup (AIX 7300‑03‑00)            #
############################################
data "ibm_pi_image" "aix" {
  pi_cloud_instance_id = local.workspace_id
  pi_image_name        = var.image_name                 # default "AIX 7300-03-00"
}

############################################
# Power Virtual Server instance            #
############################################
resource "ibm_pi_instance" "vm" {
  pi_cloud_instance_id = local.workspace_id
  pi_instance_name     = var.instance_name

  # Defaults requested
  pi_memory            = 2           # GiB
  pi_processors        = 0.25        # cores
  pi_proc_type         = "shared"    # uncapped
  pi_sys_type          = "e980"

  pi_image_id          = data.ibm_pi_image.aix.id
  pi_key_pair_name     = local.key_name

  # Attach to subnet
  pi_network {
    network_id = local.subnet_id
  }
}

