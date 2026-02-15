output "glb_nsg_id" {
  description = "ID of the GLB subnets NSG"
  value       = azurerm_network_security_group.glb.id
}

output "glb_nsg_name" {
  description = "Name of the GLB subnets NSG"
  value       = azurerm_network_security_group.glb.name
}

output "glb_route_table_id" {
  description = "ID of the GLB route table"
  value       = azurerm_route_table.glb.id
}

output "glb_route_table_name" {
  description = "Name of the GLB route table"
  value       = azurerm_route_table.glb.name
}

output "glb_routes" {
  description = "GLB route table routes"
  value = length(azurerm_route.glb) > 0 ? {
    for k, route in azurerm_route.glb : k => {
      name                   = route.name
      address_prefix         = route.address_prefix
      next_hop_type          = route.next_hop_type
      next_hop_in_ip_address = route.next_hop_in_ip_address
    }
  } : {}
}

output "vmss_id" {
  description = "ID of the vmss VMSS"
  value       = azurerm_linux_virtual_machine_scale_set.vmss.id
}

output "vmss_name" {
  description = "Name of the vmss VMSS"
  value       = azurerm_linux_virtual_machine_scale_set.vmss.name
}

output "vmss_nsg_id" {
  description = "ID of the vmss subnets NSG"
  value       = azurerm_network_security_group.vmss.id
}

output "vmss_nsg_name" {
  description = "Name of the vmss subnets NSG"
  value       = azurerm_network_security_group.vmss.name
}

output "vmss_route_table_id" {
  description = "ID of the vmss route table"
  value       = azurerm_route_table.vmss.id
}

output "vmss_route_table_name" {
  description = "Name of the vmss route table"
  value       = azurerm_route_table.vmss.name
}

output "vmss_routes" {
  description = "vmss route table routes"
  value = length(azurerm_route.vmss) > 0 ? {
    for k, route in azurerm_route.vmss : k => {
      name                   = route.name
      address_prefix         = route.address_prefix
      next_hop_type          = route.next_hop_type
      next_hop_in_ip_address = route.next_hop_in_ip_address
    }
  } : {}
}

