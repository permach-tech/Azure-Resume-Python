resource "azurerm_cosmosdb_account" "db" {
  name                = var.cosmosdb_name
  location            = var.location
  resource_group_name = var.api_resource_group_name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  capabilities {
    name = "EnableServerless"
  }

  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = azurerm_resource_group.azure_rg.location
    failover_priority = 0
  }
}

resource "azurerm_cosmosdb_sql_database" "sql_db" {
  name                = var.cosmosdb_sql_db_name
  resource_group_name = var.api_resource_group_name
  account_name        = azurerm_cosmosdb_account.db.name
}

resource "azurerm_cosmosdb_sql_container" "sql_container" {
  name                = "resumecounter"
  resource_group_name = var.api_resource_group_name
  account_name        = azurerm_cosmosdb_account.db.name
  database_name       = azurerm_cosmosdb_sql_database.sql_db.name
  partition_key_path  = "/id"
  throughput          = 400
}