locals {
  private_subnet_cidrs_filtered = [for cidr in var.private_subnet_cidrs : cidr if cidr != ""]
  public_subnet_cidrs_filtered  = [for cidr in var.public_subnet_cidrs : cidr if cidr != ""]
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.project_name}-${var.environment}-vnet"
  address_space       = [var.vnet_cidr]
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tags
}
