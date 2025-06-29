variable "sql_server_name" {
  description = "The name of the SQL Server."
  type        = string
    default     = "sqlserver119911"
  
}

variable "resource_group_name" {
    description = "The name of the resource group in which the SQL Server will be created."
    type        = string
    default     = "rgdemo"
  
}

variable "location" {
  description = "value for the location of the SQL Server."
  type        = string
  default     = "westus"
}   

variable "username" {
  description = "The administrator username for the SQL Server."
  type        = string
  default     = "sqladmin"
  
}

variable "password" {
  description = "The administrator password for the SQL Server."
  type        = string
  default     = "P@ssw0rd1234!"
  
}


