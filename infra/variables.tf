variable "location" {
  description = "The location/region where the Azure resources will be created."
}

variable "resource_group_name" {
  description = "The name of the resource group in which the Storage Account will be created."
}

variable "storage_account_name" {
  description = "the name of the storage account."
}

variable "api_resource_group_name" {
  description = "The name of the resource group in which the API will be created."
}

variable "api_storage_account_name" {
  description = "the name of the storage account for the API."
}

variable "cosmosdb_name" {
  description = "The name of the CosmosDB account."
}

variable "cosmosdb_sql_db_name" {
  description = "The name of the CosmosDB SQL database."
}