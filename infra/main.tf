# Create a resource group
resource "azurerm_resource_group" "azure_rg" {
  name     = var.resource_group_name
  location = var.location
}

# create a storage account
resource "azurerm_storage_account" "azure-sa" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.azure_rg.name
  location                 = azurerm_resource_group.azure_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  static_website {
    index_document     = "index.html"
    error_404_document = "404.html"
  }
}

resource "azurerm_storage_blob" "azure-blob" {
  for_each = fileset(path.module, "frontend/**")

  name                   = trimprefix(each.key, "frontend/")
  storage_account_name   = azurerm_storage_account.azure-sa.name
  storage_container_name = "$web"
  type                   = "Block"
  access_tier            = "Cool"
  source                 = each.key
  content_md5            = filemd5(each.key)
  content_type           = ""
}

resource "azurerm_resource_group" "azure_api_rg" {
  name     = var.api_resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "api_sa" {
  name                     = var.api_storage_account_name
  resource_group_name      = azurerm_resource_group.azure_api_rg.name
  location                 = azurerm_resource_group.azure_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
}

resource "azurerm_service_plan" "api_sp" {
  name                = "asp-${var.api_resource_group_name}"
  location            = azurerm_resource_group.azure_rg.location
  resource_group_name = azurerm_resource_group.azure_api_rg.name
  os_type = "Linux"
  sku_name = "Y1"
}

resource "azurerm_linux_function_app" "api_fa" {
  name                      = "fa-${var.api_resource_group_name}"
  location                  = azurerm_resource_group.azure_rg.location
  resource_group_name       = azurerm_resource_group.azure_api_rg.name
  storage_account_name      = azurerm_storage_account.api_sa.name
  storage_account_access_key = azurerm_storage_account.api_sa.primary_access_key
  service_plan_id           = azurerm_service_plan.api_sp.id
  
  site_config {
    application_stack {
      python_version = "3.8"
    }
  }
}
