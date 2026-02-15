# VNet Module Outputs
output "vnet_info" {
  description = "Complete VNet information"
  value       = module.vnet.vnet_info
}

output "vnet_id" {
  description = "VNet ID"
  value       = module.vnet.vnet_id
}

output "vnet_name" {
  description = "VNet name"
  value       = module.vnet.vnet_name
}

output "public_subnets" {
  description = "Public subnets information"
  value       = module.vnet.public_subnets
}

output "private_subnets" {
  description = "Private subnets information"
  value       = module.vnet.private_subnets
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = module.vnet.public_subnet_ids
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = module.vnet.private_subnet_ids
}

output "public_nsg_id" {
  description = "Public NSG ID"
  value       = module.vnet.public_nsg_id
}

output "private_nsg_id" {
  description = "Private NSG ID"
  value       = module.vnet.private_nsg_id
}

output "nat_gateway_id" {
  description = "NAT Gateway ID"
  value       = module.vnet.nat_gateway_id
}

output "nat_gateway_public_ip_address" {
  description = "NAT Gateway Public IP"
  value       = module.vnet.nat_gateway_public_ip_address
}

output "public_route_table_id" {
  description = "Public route table ID"
  value       = module.vnet.public_route_table_id
}

output "private_route_table_id" {
  description = "Private route table ID"
  value       = module.vnet.private_route_table_id
}

# VMs Module Outputs
output "public_vms" {
  description = "Information about public VMs"
  value       = module.vms.public_vms
}

output "private_vms" {
  description = "Information about private VMs"
  value       = module.vms.private_vms
}

output "public_vm_ids" {
  description = "List of public VM IDs"
  value       = module.vms.public_vm_ids
}

output "private_vm_ids" {
  description = "List of private VM IDs"
  value       = module.vms.private_vm_ids
}

output "public_vm_public_ips" {
  description = "List of public VM public IP addresses"
  value       = module.vms.public_vm_public_ips
}
