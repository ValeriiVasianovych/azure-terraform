terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.0"
    }
  }
  required_version = ">= 1.1.3"

  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstate3dwka"
    container_name       = "tfstate"
    key                  = "tasks/02-vnet-vmss/prod/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

# provider "random" {}

locals {
  common_tags = {
    Owner       = "Valerii Vasianovych"
    Project     = "Project: Azure Cloud vNet"
    Environment = var.environment
    Region      = "Region: ${var.location}"
  }
}

# resource "random_id" "project" {
#   byte_length = 4
# }

module "vnet" {
  source       = "../../modules/vnet"
  project_name = var.project_name
  location     = var.location
  environment  = var.environment

  vnet_cidr         = var.vnet_cidr
  glb_subnet_cidrs  = var.glb_subnet_cidrs
  vmss_subnet_cidrs = var.vmss_subnet_cidrs

  vmss_routes = var.vmss_routes

  tags = local.common_tags
}

module "vmss" {
  source = "../../modules/vmss"

  project_name        = var.project_name
  location            = var.location
  environment         = var.environment
  resource_group_name = module.vnet.resource_group_name


  glb_subnet_id     = module.vnet.glb_subnet_ids[0]
  vmss_subnet_id    = module.vnet.vmss_subnet_ids[0]
  glb_subnet_cidrs  = var.glb_subnet_cidrs
  vmss_subnet_cidrs = var.vmss_subnet_cidrs
  vmss_routes       = var.vmss_routes
  glb_routes        = var.glb_routes

  size           = var.size
  instances      = var.vmss_instances
  zones          = var.vmss_zones
  ssh_public_key = data.azurerm_ssh_public_key.default.public_key
  tags           = local.common_tags

  enable_autoscale      = var.enable_autoscale
  min_instances         = var.min_instances
  max_instances         = var.max_instances
  scale_out_cpu_percent = var.scale_out_cpu_percent
  scale_in_cpu_percent  = var.scale_in_cpu_percent
}

