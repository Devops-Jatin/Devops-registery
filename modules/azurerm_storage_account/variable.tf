variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
  default = "demostg11889"
}

variable "resource_group_name" {
  type = string
    default = "rgdemo"
}

variable "location" {
  type = string
  default = "westus"
  
}