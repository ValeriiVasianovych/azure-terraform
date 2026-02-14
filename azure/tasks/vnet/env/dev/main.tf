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
    key                  = "tasks/az-vnet/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

locals {
  common_tags = {
    Owner       = "Valerii Vasianovych"
    Project     = "Project: Azure Cloud vNet"
    Environment = var.environment
    Region      = "Region: ${var.location}"
  }
}

module "vnet" {
  source = "../../modules/vnet"

  project_name = var.project_name
  location     = var.location
  environment  = var.environment

  vnet_cidr            = var.vnet_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs

  public_routes  = var.public_routes
  private_routes = var.private_routes

  enable_nat_gateway = var.enable_nat_gateway

  tags = local.common_tags
}

module "vms" {
  source = "../../modules/vms"

  project_name        = var.project_name
  location            = var.location
  environment         = var.environment
  resource_group_name = module.vnet.resource_group_name

  public_subnet_ids  = module.vnet.public_subnet_ids
  private_subnet_ids = module.vnet.private_subnet_ids

  public_nsg_id  = module.vnet.public_nsg_id
  private_nsg_id = module.vnet.private_nsg_id

  platform_image = {
    publisher = data.azurerm_platform_image.ubuntu_latest.publisher
    offer     = data.azurerm_platform_image.ubuntu_latest.offer
    sku       = data.azurerm_platform_image.ubuntu_latest.sku
    version   = data.azurerm_platform_image.ubuntu_latest.version
  }
  size           = var.size
  ssh_public_key = data.azurerm_ssh_public_key.default.public_key
  tags           = local.common_tags
}

