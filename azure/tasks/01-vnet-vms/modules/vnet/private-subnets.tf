resource "azurerm_subnet" "private" {
  count = length(local.private_subnet_cidrs_filtered)

  name                 = "private-subnet-${var.environment}-${count.index + 1}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [local.private_subnet_cidrs_filtered[count.index]]
}

resource "azurerm_network_security_group" "private" {
  count = length(local.private_subnet_cidrs_filtered) > 0 ? 1 : 0

  name                = "${var.project_name}-${var.environment}-private-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tags
}

resource "azurerm_network_security_rule" "allow_ssh_from_vnet" {
  count = length(local.private_subnet_cidrs_filtered) > 0 ? 1 : 0

  name                        = "Allow-SSH-From-VNet"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = var.vnet_cidr
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.private[0].name
}

resource "azurerm_network_security_rule" "allow_all_outbound" {
  count = length(local.private_subnet_cidrs_filtered) > 0 ? 1 : 0

  name                        = "Allow-All-Outbound"
  priority                    = 200
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.private[0].name
}

resource "azurerm_subnet_network_security_group_association" "private_nsg_association" {
  count                     = length(azurerm_subnet.private) > 0 && length(azurerm_network_security_group.private) > 0 ? length(azurerm_subnet.private) : 0
  subnet_id                 = azurerm_subnet.private[count.index].id
  network_security_group_id = azurerm_network_security_group.private[0].id
}

resource "azurerm_public_ip" "nat_gateway" {
  count = var.enable_nat_gateway && length(local.private_subnet_cidrs_filtered) > 0 ? 1 : 0

  name                = "${var.project_name}-${var.environment}-nat-gateway-pip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_nat_gateway" "main" {
  count = var.enable_nat_gateway && length(local.private_subnet_cidrs_filtered) > 0 ? 1 : 0

  name                    = "${var.project_name}-${var.environment}-nat-gateway"
  location                = azurerm_resource_group.rg.location
  resource_group_name     = azurerm_resource_group.rg.name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  tags                    = var.tags
}

resource "azurerm_nat_gateway_public_ip_association" "main" {
  count = var.enable_nat_gateway && length(local.private_subnet_cidrs_filtered) > 0 ? 1 : 0

  nat_gateway_id       = azurerm_nat_gateway.main[0].id
  public_ip_address_id = azurerm_public_ip.nat_gateway[0].id
}

resource "azurerm_route_table" "private" {
  count = length(local.private_subnet_cidrs_filtered) > 0 ? 1 : 0

  name                = "${var.project_name}-${var.environment}-private-rt"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tags
}

resource "azurerm_route" "private" {
  for_each = length(local.private_subnet_cidrs_filtered) > 0 ? { for idx, route in var.private_routes : route.name => route } : {}

  name                   = each.value.name
  resource_group_name    = azurerm_resource_group.rg.name
  route_table_name       = azurerm_route_table.private[0].name
  address_prefix         = each.value.address_prefix
  next_hop_type          = each.value.next_hop_type
  next_hop_in_ip_address = try(each.value.next_hop_in_ip_address, null)
}

resource "azurerm_subnet_nat_gateway_association" "private" {
  count = var.enable_nat_gateway && length(local.private_subnet_cidrs_filtered) > 0 ? length(azurerm_subnet.private) : 0

  subnet_id      = azurerm_subnet.private[count.index].id
  nat_gateway_id = azurerm_nat_gateway.main[0].id
}

resource "azurerm_subnet_route_table_association" "private_rt_association" {
  count          = length(azurerm_subnet.private) > 0 && length(azurerm_route_table.private) > 0 ? length(azurerm_subnet.private) : 0
  subnet_id      = azurerm_subnet.private[count.index].id
  route_table_id = azurerm_route_table.private[0].id
}
