data "azurerm_ssh_public_key" "default" {
  name                = var.ssh_key_name
  resource_group_name = var.ssh_keys_rg
}
