resource "azurerm_cosmosdb_account" "db" {
  name                = var.cosmosdb_name
  location            = var.location
  resource_group_name = var.api_resource_group_name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  capabilities {
    name = "EnableTable"
  }

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