resource "azurerm_subnet" "vmss" {
  count = length(local.vmss_subnet_cidrs_filtered)

  name                 = "${var.environment}-${count.index + 1}-vmss-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [local.vmss_subnet_cidrs_filtered[count.index]]
}
