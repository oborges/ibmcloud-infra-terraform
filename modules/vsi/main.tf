############################################
# Terraform and required providers         #
############################################
terraform {
  required_version = ">= 1.5"

  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = ">= 1.12.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 4.0.0"
    }
  }
}

############################################
# Data sources                             #
############################################

# RHEL 8 public image (exact name supplied via var.image_name)
data "ibm_is_image" "rhel8" {
  name = var.image_name
}

# Resolve the target VPC by ID (preferred) or by name
data "ibm_is_vpc" "by_id" {
  count      = var.vpc_id != "" ? 1 : 0
  identifier = var.vpc_id
}

data "ibm_is_vpc" "by_name" {
  count = var.vpc_id == "" ? 1 : 0
  name  = var.vpc_name
}

# Pick the resolved VPC object
locals {
  vpc        = var.vpc_id != "" ? data.ibm_is_vpc.by_id[0] : data.ibm_is_vpc.by_name[0]
  ssh_key_id = var.existing_ssh_key_name != "" ? data.ibm_is_ssh_key.existing[0].id : ibm_is_ssh_key.generated[0].id
}

############################################
# Optional use of an existing SSH key      #
############################################
data "ibm_is_ssh_key" "existing" {
  count = var.existing_ssh_key_name != "" ? 1 : 0
  name  = var.existing_ssh_key_name
}

############################################
# Automatically generate an SSH key        #
############################################
resource "tls_private_key" "generated" {
  count     = var.existing_ssh_key_name == "" ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "ibm_is_ssh_key" "generated" {
  count          = var.existing_ssh_key_name == "" ? 1 : 0
  name           = "${var.instance_name}-key"
  public_key     = tls_private_key.generated[0].public_key_openssh
  resource_group = local.vpc.resource_group
}

############################################
# Security group that only allows SSH      #
############################################
resource "ibm_is_security_group" "ssh_only" {
  name           = "${var.instance_name}-sg"
  vpc            = local.vpc.id
  resource_group = local.vpc.resource_group
  tags           = concat(var.tags, ["env:${var.environment}"])
}

resource "ibm_is_security_group_rule" "inbound_ssh" {
  group     = ibm_is_security_group.ssh_only.id
  direction = "inbound"
  remote    = var.allowed_ssh_cidr
  tcp {
    port_min = 22
    port_max = 22
  }
}

############################################
# Virtual Server Instance                  #
############################################
resource "ibm_is_instance" "this" {
  name           = var.instance_name
  vpc            = local.vpc.id
  zone           = var.zone
  profile        = var.profile
  image          = data.ibm_is_image.rhel8.id
  resource_group = local.vpc.resource_group
  tags           = concat(var.tags, ["env:${var.environment}"])

  primary_network_interface {
    subnet          = var.subnet_id
    security_groups = [ibm_is_security_group.ssh_only.id]
  }

  keys = [local.ssh_key_id]
}

############################################
# Optional floating IP                     #
############################################
resource "ibm_is_floating_ip" "fip" {
  count          = var.attach_floating_ip ? 1 : 0
  name           = "${var.instance_name}-fip"
  target         = ibm_is_instance.this.primary_network_interface[0].id
  zone           = var.zone
  resource_group = local.vpc.resource_group
}

