variable "vnet_name" {
    description = "The name of the virtual network."
    type        = string
    default     = "myVnet"
    
  }

  variable "location" {
    description = "The Azure region where the virtual network will be created."
    type        = string
    default     = "westus"
    
  }

  variable "resource_group_name" {
    description = "The name of the resource group where the virtual network will be created."
    type        = string
    default     = "rgdemo"
    
  }