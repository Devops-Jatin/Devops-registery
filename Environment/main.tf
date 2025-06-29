module "resource_group" {
  source = "../modules/azurerm_resource_group"
}

module "storage_account" {
  source     = "../modules/azurerm_storage_account"
  depends_on = [module.resource_group]

}

module "vnet" {
  source     = "../modules/azurerm_vnet"
  depends_on = [module.resource_group]

}

module "subnet" {
  source     = "../modules/azurerm_subnet"
  depends_on = [module.vnet]
}

module "sql_server" {
  source = "../modules/azurerm_sql_server"
}

module "sql_database" {
  source        = "../modules/azurerm_sql_database"
  depends_on    = [module.sql_server]
  sql_server_id = "/subscriptions/92e22e38-2f32-450c-97de-3c896645b2da/resourceGroups/rgdemo/providers/Microsoft.Sql/servers/sqlserver119911"
}


module "Publicip" {
  source     = "../modules/azurerm_pip"
  depends_on = [module.resource_group]

}

module "vm" {
  source          = "../modules/azurerm_linux_vm"
  depends_on      = [module.resource_group, module.vnet, module.subnet, module.Publicip]
  image_publisher = "Canonical"
  image_offer     = "0001-com-ubuntu-server-focal"
  image_sku       = "20_04-lts"
  image_version   = "latest"


}