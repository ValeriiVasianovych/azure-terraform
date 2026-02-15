resource "azurerm_subnet" "glb" {
  count = length(local.glb_subnet_cidrs_filtered)

  name                 = "${var.environment}-${count.index + 1}-gateway-lb-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [local.glb_subnet_cidrs_filtered[count.index]]
}