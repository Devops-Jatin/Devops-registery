variable "resource_group_name" {
    description = "The name of the resource group"
    type        = string
    default     = "rgdemo"
    
  }
  variable "virtual_network_name" {
    description = "The name of the virtual network"
    type        = string
    default     = "myvnet"
    
  }

  variable "snet_name" {
    description = "The name of the subnet"
    type        = string
    default     = "my-subnet" 
  }