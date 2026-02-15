resource "azurerm_network_security_group" "glb" {

  name                = "${var.project_name}-${var.environment}-glb-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# Required for Application Gateway v2: control plane and health probes (Azure docs)
resource "azurerm_network_security_rule" "glb_gateway_manager" {
  name                        = "AllowGatewayManager"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["65200-65535"]
  source_address_prefix       = "GatewayManager"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.glb.name
}

resource "azurerm_network_security_rule" "glb_azure_lb" {
  name                        = "AllowAzureLoadBalancer"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["65200-65535"]
  source_address_prefix       = "AzureLoadBalancer"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.glb.name
}

resource "azurerm_network_security_rule" "glb_ports" {
  name                        = "GLB-Rules"
  priority                    = 120
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["80", "443"]
  source_address_prefix       = "Internet"
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.glb.name
  resource_group_name         = var.resource_group_name
}

resource "azurerm_subnet_network_security_group_association" "glb_nsg_association" {
  subnet_id                 = var.glb_subnet_id
  network_security_group_id = azurerm_network_security_group.glb.id
}

resource "azurerm_route_table" "glb" {
  name                = "${var.project_name}-${var.environment}-glb-rt"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_route" "glb" {
  for_each = { for r in var.glb_routes : r.name => r }

  name                   = each.value.name
  resource_group_name    = var.resource_group_name
  route_table_name       = azurerm_route_table.glb.name
  address_prefix         = each.value.address_prefix
  next_hop_type          = each.value.next_hop_type
  next_hop_in_ip_address = try(each.value.next_hop_in_ip_address, null)
}

resource "azurerm_subnet_route_table_association" "glb_rt_association" {
  subnet_id      = var.glb_subnet_id
  route_table_id = azurerm_route_table.glb.id
}
