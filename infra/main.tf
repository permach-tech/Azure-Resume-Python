provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "azure_rg" {
  name = "rg-az-resume-python-prod-001"
  location = "southcentralus"
}

# create a storage account
resource "azurerm_storage_account" "azure-sa" {
    name                     = "stazpythresume001"
    resource_group_name      = azurerm_resource_group.azure_rg.name
    location                 = azurerm_resource_group.azure_rg.location
    account_tier             = "Standard"
    account_replication_type = "LRS"
    account_kind = "StorageV2"

    static_website {
        index_document = "index.html"
    }
}

# add a index.html file

resource "azurerm_storage_blob" "azure-blob" {
    for_each = fileset(path.module, "frontend/**")

  name                   = each.key
  storage_account_name   = azurerm_storage_account.azure-sa.name
  storage_container_name = "$web"
  type                   = "Block"
  source                 = each.key
}