resource "azurerm_network_interface" "public" {
  count = length(var.public_subnet_ids)

  name                = "${var.project_name}-${var.environment}-public-nic-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.public_subnet_ids[count.index]
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public[count.index].id
  }
}

resource "azurerm_public_ip" "public" {
  count = length(var.public_subnet_ids)

  name                = "${var.project_name}-${var.environment}-public-ip-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_network_interface_security_group_association" "public" {
  count = length(var.public_subnet_ids)

  network_interface_id      = azurerm_network_interface.public[count.index].id
  network_security_group_id = var.public_nsg_id
}

resource "azurerm_linux_virtual_machine" "public" {
  count = length(var.public_subnet_ids)

  name                = "${var.project_name}-${var.environment}-public-vm-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = var.size
  admin_username      = "azureuser"
  tags                = var.tags

  network_interface_ids = [
    azurerm_network_interface.public[count.index].id,
  ]

  admin_ssh_key {
    username   = "azureuser"
    public_key = var.ssh_public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.platform_image.publisher
    offer     = var.platform_image.offer
    sku       = var.platform_image.sku
    version   = var.platform_image.version
  }

  disable_password_authentication = true
}

