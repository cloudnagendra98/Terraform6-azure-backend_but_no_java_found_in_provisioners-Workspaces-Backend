resource "azurerm_mssql_server" "ntierserver" {
  name                          = var.db_info.server_name
  resource_group_name           = azurerm_resource_group.ntier_resg.name
  location                      = azurerm_resource_group.ntier_resg.location
  version                       = var.db_info.server_version
  administrator_login           = var.db_info.user_name
  administrator_login_password  = var.db_info.password
  public_network_access_enabled = true


  depends_on = [
    azurerm_resource_group.ntier_resg,
    azurerm_virtual_network.ntier_vnet,
    azurerm_network_security_group.dbnsg
  ]



}



resource "azurerm_mssql_database" "db" {
  name        = var.db_info.db_name
  server_id   = azurerm_mssql_server.ntierserver.id
  max_size_gb = var.db_info.max_size_gb
  sku_name    = var.db_info.sku_name

  depends_on = [
    azurerm_virtual_network.ntier_vnet,
    azurerm_network_security_group.dbnsg,
    azurerm_mssql_server.ntierserver
  ]

}
