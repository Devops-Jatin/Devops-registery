data "azurerm_public_ip" "public_ip_name" {
  name                = var.pip_name
  resource_group_name = var.resource_group_name
}

data "azurerm_subnet" "subnet_name" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = "rgdemo"
}
