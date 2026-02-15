data "azurerm_platform_image" "ubuntu_latest" {
  location  = var.location
  publisher = "Canonical"
  offer     = "0001-com-ubuntu-server-jammy"
  sku       = "22_04-lts-gen2"
}

data "azurerm_ssh_public_key" "default" {
  name                = var.ssh_key_name
  resource_group_name = var.ssh_keys_rg
}
