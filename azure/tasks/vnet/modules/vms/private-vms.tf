resource "azurerm_network_interface" "private" {
  count = length(var.private_subnet_ids)

  name                = "${var.project_name}-${var.environment}-private-nic-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.private_subnet_ids[count.index]
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface_security_group_association" "private" {
  count = length(var.private_subnet_ids)

  network_interface_id      = azurerm_network_interface.private[count.index].id
  network_security_group_id = var.private_nsg_id
}

resource "azurerm_linux_virtual_machine" "private" {
  count = length(var.private_subnet_ids)

  name                = "${var.project_name}-${var.environment}-private-vm-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = var.size
  admin_username      = "azureuser"
  tags                = var.tags

  network_interface_ids = [
    azurerm_network_interface.private[count.index].id,
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

