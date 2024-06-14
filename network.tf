resource "azurerm_virtual_network" "ntier_vnet" {
  name                = "ntier_vnet"
  resource_group_name = azurerm_resource_group.ntier_resg.name
  address_space       = var.vnet_network_cidr
  location            = azurerm_resource_group.ntier_resg.location

  depends_on = [
    azurerm_resource_group.ntier_resg
  ]
}

resource "azurerm_subnet" "subnets" {
  count                = length(var.subnet_cidr_range)
  name                 = var.subnet_names[count.index]
  resource_group_name  = azurerm_resource_group.ntier_resg.name
  virtual_network_name = azurerm_virtual_network.ntier_vnet.name
  address_prefixes     = [var.subnet_cidr_range[count.index]]

  depends_on = [
    azurerm_resource_group.ntier_resg,
    azurerm_virtual_network.ntier_vnet
  ]

}