resource "azurerm_public_ip" "public_ip" {
  name                = var.appvm_config.public_ip_name
  resource_group_name = azurerm_resource_group.ntier_resg.name
  location            = azurerm_resource_group.ntier_resg.location
  allocation_method   = var.appvm_config.allocation_method

}

data "azurerm_subnet" "app_subnet" {
  name                 = var.appvm_config.app_subnet_name
  virtual_network_name = azurerm_virtual_network.ntier_vnet.name
  resource_group_name  = azurerm_resource_group.ntier_resg.name

  depends_on = [
    azurerm_subnet.subnets
  ]
}

resource "azurerm_network_interface" "nifc" {
  name                = var.appvm_config.network_interface_name
  resource_group_name = azurerm_resource_group.ntier_resg.name
  location            = azurerm_resource_group.ntier_resg.location
  ip_configuration {
    name                          = var.appvm_config.ip_name
    subnet_id                     = data.azurerm_subnet.app_subnet.id
    private_ip_address_allocation = var.appvm_config.private_ip_address_allocation
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
  depends_on = [

    azurerm_subnet.subnets,
    azurerm_network_security_group.appnsg,
    azurerm_public_ip.public_ip,
    data.azurerm_subnet.app_subnet
  ]
}

resource "azurerm_network_interface_security_group_association" "nifc_nsg_association" {
  network_interface_id      = azurerm_network_interface.nifc.id
  network_security_group_id = azurerm_network_security_group.appnsg.id

  depends_on = [
    azurerm_network_interface.nifc,
    azurerm_network_security_group.appnsg
  ]
}


resource "azurerm_linux_virtual_machine" "appvm" {
  name                = var.appvm_config.appvm_name
  resource_group_name = azurerm_resource_group.ntier_resg.name
  location            = azurerm_resource_group.ntier_resg.location
  admin_username      = var.appvm_config.username
  size                = var.appvm_config.size

  admin_ssh_key {
    username   = var.appvm_config.username
    public_key = file(var.appvm_config.public_key_path)
  }
  network_interface_ids = [azurerm_network_interface.nifc.id]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.appvm_config.publisher
    offer     = var.appvm_config.offer
    sku       = var.appvm_config.sku
    version   = var.appvm_config.version
  }

  depends_on = [
    azurerm_virtual_network.ntier_vnet,
    azurerm_subnet.subnets,
    data.azurerm_subnet.app_subnet,
    azurerm_network_interface.nifc,
    azurerm_network_security_group.appnsg
  ]
}
