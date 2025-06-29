resource "azurerm_mssql_server" "sql_server" {
  name                         = var . sql_server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var . username
  administrator_login_password = var. password
  minimum_tls_version          = "1.2"
  
}

