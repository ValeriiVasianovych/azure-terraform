output "public_vms" {
  description = "Information about public VMs"
  value = length(azurerm_linux_virtual_machine.public) > 0 ? {
    for idx, vm in azurerm_linux_virtual_machine.public : vm.name => {
      id                   = vm.id
      name                 = vm.name
      private_ip           = azurerm_network_interface.public[idx].ip_configuration[0].private_ip_address
      public_ip            = azurerm_public_ip.public[idx].ip_address
      public_ip_id         = azurerm_public_ip.public[idx].id
      network_interface_id = azurerm_network_interface.public[idx].id
    }
  } : {}
}

output "private_vms" {
  description = "Information about private VMs"
  value = length(azurerm_linux_virtual_machine.private) > 0 ? {
    for idx, vm in azurerm_linux_virtual_machine.private : vm.name => {
      id                   = vm.id
      name                 = vm.name
      private_ip           = azurerm_network_interface.private[idx].ip_configuration[0].private_ip_address
      network_interface_id = azurerm_network_interface.private[idx].id
    }
  } : {}
}

output "public_vm_ids" {
  description = "List of public VM IDs"
  value       = [for vm in azurerm_linux_virtual_machine.public : vm.id]
}

output "private_vm_ids" {
  description = "List of private VM IDs"
  value       = [for vm in azurerm_linux_virtual_machine.private : vm.id]
}

output "public_vm_public_ips" {
  description = "List of public VM public IP addresses"
  value       = [for ip in azurerm_public_ip.public : ip.ip_address]
}

