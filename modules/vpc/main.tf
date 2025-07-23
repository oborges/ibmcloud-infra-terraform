############################
# Terraform + IBM provider #
############################
terraform {
  required_version = ">= 1.5"

  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = ">= 1.12.0"
    }
  }
}

####################
# Data & Variables #
####################
# Resource‑group lookup avoids hard‑coding UUIDs
data "ibm_resource_group" "rg" {
  name = var.resource_group
}

# Derive one /24 subnet per zone (/16 -> /24 = +8 bits)
locals {
  zone_count   = length(var.zones)
  subnet_cidrs = [
    for idx in range(local.zone_count) :
    cidrsubnet(var.vpc_cidr, 8, idx)
  ]
}

########
# VPC  #
########
resource "ibm_is_vpc" "this" {
  name            = var.vpc_name
  resource_group  = data.ibm_resource_group.rg.id
  tags            = concat(var.tags, ["env:${var.environment}"])
}

#####################
# Public Gateways   #
#####################
resource "ibm_is_public_gateway" "pg" {
  for_each       = toset(var.zones)

  name           = "${var.vpc_name}-pg-${each.value}"
  vpc            = ibm_is_vpc.this.id
  zone           = each.value
  resource_group = data.ibm_resource_group.rg.id
}

############
# Subnets  #
############
resource "ibm_is_subnet" "subnet" {
  for_each = { for idx, zone in var.zones : zone => idx }

  name            = "${var.vpc_name}-${each.key}"
  vpc             = ibm_is_vpc.this.id
  zone            = each.key
  ipv4_cidr_block = local.subnet_cidrs[each.value]
  resource_group  = data.ibm_resource_group.rg.id
  public_gateway  = ibm_is_public_gateway.pg[each.key].id

  lifecycle {
    prevent_destroy = true   # safeguard against accidental deletes
  }
}

