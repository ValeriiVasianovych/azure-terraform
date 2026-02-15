resource "azurerm_virtual_network" "vnet" {
  name                = "${var.project_name}-${var.environment}-vnet"
  address_space       = [var.vnet_cidr]
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tags
}

locals {
  glb_subnet_cidrs_filtered  = [for cidr in var.glb_subnet_cidrs : cidr if cidr != ""]
  vmss_subnet_cidrs_filtered = [for cidr in var.vmss_subnet_cidrs : cidr if cidr != ""]
}
