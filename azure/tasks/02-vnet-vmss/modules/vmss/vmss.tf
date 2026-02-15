# Single VMSS; instances spread across availability zones when var.zones is set.
resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                = "${var.project_name}-${var.environment}-vmss"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.size
  instances           = var.instances
  overprovision       = false
  admin_username      = "azureuser"
  tags                = var.tags
  zones               = var.zones

  custom_data = base64encode(
    file("${path.module}/scripts/install_nginx.sh")
  )

  network_interface {
    name    = "nic"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = var.vmss_subnet_id

      application_gateway_backend_address_pool_ids = [
        "${azurerm_application_gateway.glb.id}/backendAddressPools/vmss-pool"
      ]
    }
  }

  admin_ssh_key {
    username   = "azureuser"
    public_key = var.ssh_public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = local.platform_image.publisher
    offer     = local.platform_image.offer
    sku       = local.platform_image.sku
    version   = local.platform_image.version
  }

  disable_password_authentication = true
}
