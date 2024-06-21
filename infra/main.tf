resource "random_string" "unique_suffix" {
  length  = 4
  upper   = false
  numeric = true
  special = false
}

data "archive_file" "function_zip" {
  type        = "zip"
  source_dir  = "../function"
  output_path = "function-${timestamp()}.zip"
}

resource "azurerm_resource_group" "resource_group" {
  name     = "function-resource-group-${random_string.unique_suffix.result}"
  location = "West Europe"
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "fastapifunction${random_string.unique_suffix.result}"
  resource_group_name      = azurerm_resource_group.resource_group.name
  location                 = azurerm_resource_group.resource_group.location
  account_kind             = "Storage"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_application_insights" "application_insights" {
  name                = "function-application-insights-${random_string.unique_suffix.result}"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  application_type    = "other"
}

resource "azurerm_service_plan" "service_plan" {
  name                = "function-service-plan"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  os_type             = "Linux"
  sku_name            = "Y1"
}

resource "azurerm_linux_function_app" "function_app" {
  name                        = "function-app-${random_string.unique_suffix.result}"
  resource_group_name         = azurerm_resource_group.resource_group.name
  location                    = azurerm_resource_group.resource_group.location
  service_plan_id             = azurerm_service_plan.service_plan.id
  storage_account_name        = azurerm_storage_account.storage_account.name
  storage_account_access_key  = azurerm_storage_account.storage_account.primary_access_key
  https_only                  = true
  functions_extension_version = "~4"
  identity {
    type = "SystemAssigned"
  }
  app_settings = {
    ENABLE_ORYX_BUILD              = "true"
    SCM_DO_BUILD_DURING_DEPLOYMENT = "true"
    FUNCTIONS_WORKER_RUNTIME       = "python"
    AzureWebJobsFeatureFlags       = "EnableWorkerIndexing"
    APPINSIGHTS_INSTRUMENTATIONKEY = azurerm_application_insights.application_insights.instrumentation_key
  }
  site_config {
    application_stack {
      python_version = "3.11"
    }
  }
  zip_deploy_file = data.archive_file.function_zip.output_path
  depends_on      = [data.archive_file.function_zip]
}
