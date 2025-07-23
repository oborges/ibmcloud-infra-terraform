terraform {
  required_version = ">= 1.6"
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = ">= 2.0.0"
    }
  }
}

########################
#  Data & Locals
########################
# Look‑up the resource group by name (avoids hard‑coding its UUID)
data "ibm_resource_group" "rg" {
  name = var.resource_group
}

# Derive one /24 subnet CIDR per zone from the base /16 network
locals {
  zone_count   = length(var.zones)
  subnet_cidrs = [
    for idx in range(local.zone_count) :
    cidrsubnet(var.vpc_cidr, 8, idx)   # 8 extra bits => /24
  ]
}

########################
#  VPC
########################
resource "ibm_is_vpc" "this" {
  name            = var.vpc_name
  resource_group  = data.ibm_resource_group.rg.id
  classic_access  = false           # best practice: disable unless required
  tags            = concat(var.tags, ["env:${var.environment}"])
}

########################
#  Public Gateways (one per zone)
########################
resource "ibm_is_public_gateway" "pg" {
  for_each       = toset(var.zones)

  name           = "${var.vpc_name}-pg-${each.value}"
  vpc            = ibm_is_vpc.this.id
  zone           = each.value
  resource_group = data.ibm_resource_group.rg.id
}

########################
#  Subnets (one per zone)
########################
resource "ibm_is_subnet" "subnet" {
  for_each = { for idx, zone in var.zones : zone => idx }

  name             = "${var.vpc_name}-${each.key}"
  vpc              = ibm_is_vpc.this.id
  zone             = each.key
  ipv4_cidr_block  = local.subnet_cidrs[each.value]
  resource_group   = data.ibm_resource_group.rg.id
  public_gateway   = ibm_is_public_gateway.pg[each.key].id

  # Protect running workloads from an accidental 'terraform destroy'
  lifecycle {
    prevent_destroy = true
  }
}

