
variable "pip_name" {
    description = "The name of the Public IP"
    type        = string
    default     = "myPublicIP"
  
}
variable "resource_group_name" {
    description = "The name of the Resource Group where the Public IP will be created"
    type        = string
    default     = "rgdemo"
  
}
variable "location" {
    description = "The Azure region where the Public IP will be created"
    type        = string
    default     = "westus"
  
}