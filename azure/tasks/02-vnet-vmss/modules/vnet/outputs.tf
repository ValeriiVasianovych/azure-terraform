output "resource_group_name" {
  description = "Name of the created resource group"
  value       = azurerm_resource_group.rg.name
}

output "resource_group_id" {
  description = "ID of the created resource group"
  value       = azurerm_resource_group.rg.id
}

output "resource_group_location" {
  description = "Location of the created resource group"
  value       = azurerm_resource_group.rg.location
}

output "vnet_name" {
  description = "Name of the created virtual network"
  value       = azurerm_virtual_network.vnet.name
}

output "vnet_id" {
  description = "ID of the created virtual network"
  value       = azurerm_virtual_network.vnet.id
}

output "vnet_address_space" {
  description = "Address space of the virtual network"
  value       = azurerm_virtual_network.vnet.address_space
}

output "glb_subnets" {
  description = "Information about GLB subnets"
  value = length(azurerm_subnet.glb) > 0 ? {
    for idx, subnet in azurerm_subnet.glb : subnet.name => {
      id             = subnet.id
      address_prefix = subnet.address_prefixes[0]
      name           = subnet.name
    }
  } : {}
}

output "glb_subnet_ids" {
  description = "List of GLB subnet IDs"
  value       = [for subnet in azurerm_subnet.glb : subnet.id]
}

output "glb_subnet_names" {
  description = "List of GLB subnet names"
  value       = [for subnet in azurerm_subnet.glb : subnet.name]
}

output "vmss_subnets" {
  description = "Information about vmss subnets"
  value = length(azurerm_subnet.vmss) > 0 ? {
    for idx, subnet in azurerm_subnet.vmss : subnet.name => {
      id             = subnet.id
      address_prefix = subnet.address_prefixes[0]
      name           = subnet.name
    }
  } : {}
}

output "vmss_subnet_ids" {
  description = "List of vmss subnet IDs"
  value       = [for subnet in azurerm_subnet.vmss : subnet.id]
}

output "vmss_subnet_names" {
  description = "List of vmss subnet names"
  value       = [for subnet in azurerm_subnet.vmss : subnet.name]
}