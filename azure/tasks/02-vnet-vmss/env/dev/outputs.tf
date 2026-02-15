output "resource_group_name" {
  description = "Name of the created resource group"
  value       = module.vnet.resource_group_name
}

output "resource_group_id" {
  description = "ID of the created resource group"
  value       = module.vnet.resource_group_id
}

output "resource_group_location" {
  description = "Location of the created resource group"
  value       = module.vnet.resource_group_location
}

output "vnet_name" {
  description = "Name of the created virtual network"
  value       = module.vnet.vnet_name
}

output "vnet_id" {
  description = "ID of the created virtual network"
  value       = module.vnet.vnet_id
}

output "vnet_address_space" {
  description = "Address space of the virtual network"
  value       = module.vnet.vnet_address_space
}

output "glb_subnets" {
  description = "Information about GLB subnets"
  value       = module.vnet.glb_subnets
}

output "glb_subnet_ids" {
  description = "List of GLB subnet IDs"
  value       = module.vnet.glb_subnet_ids
}

output "glb_subnet_names" {
  description = "List of GLB subnet names"
  value       = module.vnet.glb_subnet_names
}

output "glb_nsg_id" {
  description = "ID of the GLB subnets NSG"
  value       = module.vmss.glb_nsg_id
}

output "glb_nsg_name" {
  description = "Name of the GLB subnets NSG"
  value       = module.vmss.glb_nsg_name
}

output "glb_route_table_id" {
  description = "ID of the GLB route table"
  value       = module.vmss.glb_route_table_id
}

output "glb_route_table_name" {
  description = "Name of the GLB route table"
  value       = module.vmss.glb_route_table_name
}

output "glb_routes" {
  description = "GLB route table routes"
  value       = module.vmss.glb_routes
}

output "vmss_subnets" {
  description = "Information about vmss subnets"
  value       = module.vnet.vmss_subnets
}

output "vmss_subnet_ids" {
  description = "List of vmss subnet IDs"
  value       = module.vnet.vmss_subnet_ids
}

output "vmss_subnet_names" {
  description = "List of vmss subnet names"
  value       = module.vnet.vmss_subnet_names
}

output "vmss_nsg_id" {
  description = "ID of the vmss subnets NSG"
  value       = module.vmss.vmss_nsg_id
}

output "vmss_nsg_name" {
  description = "Name of the vmss subnets NSG"
  value       = module.vmss.vmss_nsg_name
}

output "vmss_route_table_id" {
  description = "ID of the vmss route table"
  value       = module.vmss.vmss_route_table_id
}

output "vmss_route_table_name" {
  description = "Name of the vmss route table"
  value       = module.vmss.vmss_route_table_name
}

output "vmss_routes" {
  description = "vmss route table routes"
  value       = module.vmss.vmss_routes
}