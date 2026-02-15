resource "azurerm_network_security_group" "vmss" {
  name                = "${var.project_name}-${var.environment}-vmss-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# Access only from App Gateway subnet and on ports 80, 443, and 22 for management
resource "azurerm_network_security_rule" "vmss_rules" {
  name                        = "From-GLB-To-VMSS"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["80", "443", "22"]
  source_address_prefix       = length(var.glb_subnet_cidrs) > 0 ? var.glb_subnet_cidrs[0] : "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.vmss.name
}

resource "azurerm_subnet_network_security_group_association" "vmss_nsg_association" {
  subnet_id                 = var.vmss_subnet_id
  network_security_group_id = azurerm_network_security_group.vmss.id
}

resource "azurerm_route_table" "vmss" {
  name                = "${var.project_name}-${var.environment}-vmss-rt"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_route" "vmss" {
  for_each = { for r in var.vmss_routes : r.name => r }

  name                   = each.value.name
  resource_group_name    = var.resource_group_name
  route_table_name       = azurerm_route_table.vmss.name
  address_prefix         = each.value.address_prefix
  next_hop_type          = each.value.next_hop_type
  next_hop_in_ip_address = try(each.value.next_hop_in_ip_address, null)
}

resource "azurerm_subnet_route_table_association" "vmss_rt_association" {
  subnet_id      = var.vmss_subnet_id
  route_table_id = azurerm_route_table.vmss.id
}
