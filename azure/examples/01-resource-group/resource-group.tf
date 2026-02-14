terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstate3dwka"
    container_name       = "tfstate"
    key                  = "examples/01-resource-group/terraform.tfstate"
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id
  features {}
}

resource "azurerm_resource_group" "state-demo-secure" {
  name     = "demo-rg"
  location = "West Europe"
}
