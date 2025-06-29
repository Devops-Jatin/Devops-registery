variable "resource_group_name" {
  description = "The name of the resource group in which to create the virtual machine."
  type        = string
  default = "rgdemo"
}

variable "location" {
  description = "The Azure region where the virtual machine will be created."
  type        = string
    default     = "westUS"
}

variable "vm_name" {
  description = "The name of the virtual machine."
  type        = string
  default = "my-linux-vm1111"
}



variable "admin_username" {
  description = "The administrator username for the virtual machine."
  type        = string
  default = "adminuser"
}
variable "admin_password" {
  description = "The administrator password for the virtual machine."
  type        = string
    default = "P@ssw0rd1234!"
}

variable "image_publisher" {
  description = "The publisher of the image to use for the virtual machine."
  type        = string
}

variable "image_offer" {
  description = "The offer of the image to use for the virtual machine."
  type        = string
}

variable "image_sku" {
  description = "The SKU of the image to use for the virtual machine."
  type        = string
}

variable "image_version" {
  description = "The version of the image to use for the virtual machine."
  type        = string
}

variable "nic_name" {
  description = "The name of the network interface for the virtual machine."
  type        = string
  default = "nic_name"
}

variable "pip_name" {
  description = "IP ka naam"
  type        = string
  default = "myPublicIP"
}

variable "subnet_name" {
  description = "Subnet ka naam"
  type        = string
  default = "my-subnet"
}

variable "vnet_name" {
  description = "Vnet ka naam"
  type        = string
  default = "myVnet"
}
