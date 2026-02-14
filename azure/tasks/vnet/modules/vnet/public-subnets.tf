resource "azurerm_subnet" "public" {
  count = length(local.public_subnet_cidrs_filtered)

  name                 = "public-subnet-${var.environment}-${count.index + 1}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [local.public_subnet_cidrs_filtered[count.index]]
}

resource "azurerm_network_security_group" "public" {
  count = length(local.public_subnet_cidrs_filtered) > 0 ? 1 : 0

  name                = "${var.project_name}-${var.environment}-public-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tags
}

resource "azurerm_network_security_rule" "allow_http_https" {
  count = length(local.public_subnet_cidrs_filtered) > 0 ? 1 : 0

  name                        = "Allow-HTTP-HTTPS"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["80", "443", "22"]
  source_address_prefix       = "Internet"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.public[0].name
}

resource "azurerm_subnet_network_security_group_association" "public_nsg_association" {
  count                     = length(azurerm_subnet.public) > 0 && length(azurerm_network_security_group.public) > 0 ? length(azurerm_subnet.public) : 0
  subnet_id                 = azurerm_subnet.public[count.index].id
  network_security_group_id = azurerm_network_security_group.public[0].id
}

resource "azurerm_route_table" "public" {
  count = length(local.public_subnet_cidrs_filtered) > 0 ? 1 : 0

  name                = "${var.project_name}-${var.environment}-public-rt"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tags
}

resource "azurerm_route" "public" {
  for_each = length(local.public_subnet_cidrs_filtered) > 0 ? { for idx, route in var.public_routes : route.name => route } : {}

  name                   = each.value.name
  resource_group_name    = azurerm_resource_group.rg.name
  route_table_name       = azurerm_route_table.public[0].name
  address_prefix         = each.value.address_prefix
  next_hop_type          = each.value.next_hop_type
  next_hop_in_ip_address = try(each.value.next_hop_in_ip_address, null)
}

resource "azurerm_subnet_route_table_association" "public_rt_association" {
  count          = length(azurerm_subnet.public) > 0 && length(azurerm_route_table.public) > 0 ? length(azurerm_subnet.public) : 0
  subnet_id      = azurerm_subnet.public[count.index].id
  route_table_id = azurerm_route_table.public[0].id
}
