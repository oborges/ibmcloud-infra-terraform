############################################
# Terraform & provider                     #
############################################
terraform {
  required_version = ">= 1.5"

  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = ">= 1.57.0"
    }
  }
}

############################################
# Resource group lookup                    #
############################################
data "ibm_resource_group" "rg" {
  name = var.resource_group
}

############################################
# Code Engine project (create or import)   #
############################################
resource "ibm_resource_instance" "project" {
  name              = var.project_name
  service           = "code-engine"
  plan              = "standard"
  location          = var.region
  resource_group_id = data.ibm_resource_group.rg.id
}

############################################
# Code Engine application                  #
############################################
resource "ibm_code_engine_app" "app" {
  name          = var.app_name
  project_id    = ibm_resource_instance.project.guid
  image_reference = var.image

  # Scaling & compute limits
  scale_cpu_limit       = tostring(var.cpu)          # e.g. "0.125"
  scale_memory_limit    = "${var.memory}G"           # e.g. "0.25G"
  scale_min_instances   = var.min_instances
  scale_max_instances   = var.max_instances

  # Runtime cmd & args
  run_commands  = var.run_command == "" ? [] : [var.run_command]
  run_arguments = var.run_args

  # Environment variables
  dynamic "run_env_variables" {
    for_each = var.environment_vars
    content {
      name  = run_env_variables.key
      value = run_env_variables.value
      type  = "literal"
    }
  }
}


