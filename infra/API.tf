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
  os_type             = "Linux"
  sku_name            = "Y1"
}

resource "azurerm_linux_function_app" "api_fa" {
  name                       = "fa-${var.api_resource_group_name}"
  location                   = azurerm_resource_group.azure_rg.location
  resource_group_name        = azurerm_resource_group.azure_api_rg.name
  storage_account_name       = azurerm_storage_account.api_sa.name
  storage_account_access_key = azurerm_storage_account.api_sa.primary_access_key
  service_plan_id            = azurerm_service_plan.api_sp.id

  site_config {
    application_stack {
      python_version = "3.8"
    }
    cors {
      allowed_origins = ["https://www.portal.azure.com"]
    }
  }
}