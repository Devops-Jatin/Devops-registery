module "rg" {
  source              = "../modules/azurerm_resource_group"
  location            = "westus"
  resource_group_name = "rg-new"
}

module "vnet" {
  depends_on          = [module.rg]
  source              = "../modules/azurerm_vnet"
  vnet_name           = "my-vnet"
  location            = "westus"
  resource_group_name = "rg-new"
  address_space       = ["10.0.0.0/16"]
}

module "frontend_Subnet" {
  depends_on          = [module.vnet]
  source              = "../modules/azurerm_subnet"
  resource_group_name = "rg-new"
  vnet_name           = "my-vnet"
  snet_name           = "my-subnet-frontend"
  address_prefixes    = ["10.0.1.0/24"]

}
module "backend_Subnet" {
  depends_on          = [module.vnet]
  source              = "../modules/azurerm_subnet"
  resource_group_name = "rg-new"
  vnet_name           = "my-vnet"
  snet_name           = "my-subnet-backend"
  address_prefixes    = ["10.0.2.0/24"]

}

module "frontend_pip" {
  depends_on          = [module.rg]
  source              = "../modules/azurerm_public_ip"
  location            = "westus"
  resource_group_name = "rg-new"
  pip_name            = "my-frontend-pip"
  allocation_method   = "Static"
}

module "backend_pip" {
  depends_on          = [module.rg]
  source              = "../modules/azurerm_public_ip"
  location            = "westus"
  resource_group_name = "rg-new"
  pip_name            = "my-backend-pip"
  allocation_method   = "Static"
}

module "sql_server" {
  depends_on          = [module.rg]
  source              = "../modules/azurerm_sql_server"
  location            = "westus"
  resource_group_name = "rg-new"
  sql_server_name     = "my-sql118979"
  sql_user_name       = "sql_admin"
  sql_password        = "P@ssw0rd1234!"
}

module "azurerm_mssql_database" {
  depends_on          = [module.sql_server]
  source              = "../modules/azurerm_sql_database"
  db_name             = "mysqldb"
  collation           = "SQL_Latin1_General_CP1_CI_AS"
  database_max_size   = "2"
  database_sku_name   = "S0"
  enclave_type        = "VBS"
  resource_group_name = "rg-new"
  sql_server_name     = "my-sql118979"

}

module "frontend_nsg" {
  depends_on          = [module.frontend_Subnet]
  source              = "../modules/azurerm_nsg"
  location            = "westus"
  resource_group_name = "rg-new"
  nsg_name            = "my-frontend-nsg"
  security_rule_name  = "test-nsg"
}

module "backend_nsg" {
  depends_on          = [module.backend_Subnet]
  source              = "../modules/azurerm_nsg"
  location            = "westus"
  resource_group_name = "rg-new"
  nsg_name            = "my-backend-nsg"
  security_rule_name  = "test-nsg"
}

module "kv" {
  depends_on                  = [module.rg]
  source                      = "../modules/azurerm_key_vault"
  kv_name                     = "kv112341"
  location                    = "westus"
  resource_group_name         = "rg-new"
  enabled_for_disk_encryption = "true"
  soft_delete_retention_days  = 7
  purge_protection_enabled    = "false"
  kv_sku_name                 = "standard"

}

module "kv_username_secret" {
  depends_on          = [module.kv]
  source              = "../modules/azurerm_kv_secret"
  kv_secret_name      = "vm-username"
  secret_value        = "my-secret-username"
  kv_name             = "kv112341"
  resource_group_name = "rg-new"
}

module "kv_password_secret" {
  depends_on          = [module.kv]
  source              = "../modules/azurerm_kv_secret"
  kv_secret_name      = "vm-password"
  secret_value        = "P@ssw01rd@123"
  kv_name             = "kv112341"
  resource_group_name = "rg-new"
}

module "frontend_vm" {
  depends_on              = [ module.frontend_Subnet, module.frontend_pip, module.kv, module.kv_username_secret, module.kv_password_secret]
  source                  = "../modules/azurerm_linux_vm"
  vm_name                 = "my-frontend-vm"
  resource_group_name     = "rg-new"
  location                = "westus"
  vm_size                 = "Standard_D2s_v3"
  os_storage_account_type = "Standard_LRS"
  os_image_publisher      = "Canonical"
  os_image_offer          = "0001-com-ubuntu-server-jammy"
  os_image_sku            = "22_04-lts"
  nic_name                = "my-frontend-nic"
  ip_config_name          = "my-frontend-ip-config"
  vnet_name               = "my-vnet"
  snet_name               = "my-subnet-frontend"
  pip_name                = "my-frontend-pip"
  kv_name                 = "kv112341"
  os_disk_caching         = "ReadWrite"
  admin_username          = "vm-username"
  admin_password          = "vm-password"

}

module "backend_vm" {
  depends_on              = [ module.backend_Subnet, module.backend_pip, module.kv, module.kv_username_secret, module.kv_password_secret]
  source                  = "../modules/azurerm_linux_vm"
  vm_name                 = "my-backend-vm"
  resource_group_name     = "rg-new"
  location                = "westus"
  vm_size                 = "Standard_D2s_v3"
  os_storage_account_type = "Standard_LRS"
  os_image_publisher      = "Canonical"
  os_image_offer          = "0001-com-ubuntu-server-jammy"
  os_image_sku            = "22_04-lts"
  nic_name                = "my-backend-nic"
  ip_config_name          = "my-backend-ip-config"
  vnet_name               = "my-vnet"
  snet_name               = "my-subnet-backend"
  pip_name                = "my-backend-pip"
  kv_name                 = "kv112341"
  os_disk_caching         = "ReadWrite"
  admin_username          = "vm-username"
  admin_password          = "vm-password"

}