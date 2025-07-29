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
# Resolve VPC and subnets                  #
############################################
data "ibm_is_vpc" "target" {
  name = var.vpc_name
}

data "ibm_is_subnet" "zone" {
  for_each   = var.zones
  identifier = var.subnet_ids[each.value]
}

locals {
  resource_group_id = data.ibm_is_vpc.target.resource_group
}

########################################################
# Optional Standard Cloud Object Storage
########################################################
# Decide the target resource‑group
locals {
  cos_rg = var.cos_resource_group_id != "" ? var.cos_resource_group_id : local.resource_group_id
}

resource "ibm_resource_instance" "cos" {
  count             = var.create_cos && var.cos_instance_crn == "" ? 1 : 0
  name              = var.cos_name
  service           = "cloud-object-storage"
  plan              = "standard"
  location          = "global"
  resource_group_id = local.cos_rg
  tags              = var.tags
}

# Pick the CRN: existing value, or new COS
locals {
  effective_cos_crn = var.cos_instance_crn != "" ? var.cos_instance_crn : ibm_resource_instance.cos[0].crn


############################################
# ROKS VPC cluster                         #
############################################
resource "ibm_container_vpc_cluster" "this" {
  name              = var.cluster_name
  vpc_id            = data.ibm_is_vpc.target.id
  kube_version      = var.kube_version        # e.g. "4.15_openshift"
  flavor            = var.worker_flavor
  worker_count      = var.workers_per_zone
  resource_group_id = local.resource_group_id
  cos_instance_crn  = local.effective_cos_crn
  # Make sure cluster waits until COS exists
  depends_on        = [ibm_resource_instance.cos]
  tags              = var.tags

  dynamic "zones" {
    for_each = var.zones
    content {
      name      = zones.value
      subnet_id = data.ibm_is_subnet.zone[zones.value].id
    }
  }
}

