resource "azurerm_resource_group" "rg" {
  name     = var.project_name
  location = var.location
  tags     = var.tags
}
