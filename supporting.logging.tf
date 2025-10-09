resource "azurerm_log_analytics_workspace" "this" {
  name                = module.naming.log_analytics_workspace.name_unique
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  retention_in_days   = 30
  sku                 = "PerGB2018"

  tags = local.tags
}

resource "azurerm_application_insights" "this" {
  name                = module.naming.application_insights.name_unique
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  workspace_id        = azurerm_log_analytics_workspace.this.id
  application_type    = "other"

  tags = local.tags
}

# Create diagnostic settings for the Cosmos DB account
resource "azurerm_monitor_diagnostic_setting" "cosmosdb" {
  name                       = "diag-base"
  target_resource_id         = azurerm_cosmosdb_account.this.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id

  enabled_log {
    category = "DataPlaneRequests"
  }

  enabled_log {
    category = "MongoRequests"
  }

  enabled_log {
    category = "QueryRuntimeStatistics"
  }

  enabled_log {
    category = "PartitionKeyStatistics"
  }

  enabled_log {
    category = "PartitionKeyRUConsumption"
  }

  enabled_log {
    category = "ControlPlaneRequests"
  }

  enabled_log {
    category = "CassandraRequests"
  }

  enabled_log {
    category = "GremlinRequests"
  }

  enabled_log {
    category = "TableApiRequests"
  }
}

# Create diagnostic settings for the Azure AI Search service
resource "azurerm_monitor_diagnostic_setting" "ai_search" {
  name                       = "diag-base"
  target_resource_id         = azapi_resource.ai_search.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id

  enabled_log {
    category = "OperationLogs"
  }
}

# Configure diagnostic settings for blob, file, queue, and table services to send logs to Log Analytics Workspace
resource "azurerm_monitor_diagnostic_setting" "storage_blob" {
  name                       = "diag-base"
  target_resource_id         = "${azurerm_storage_account.this.id}/blobServices/default"
  log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id

  enabled_log {
    category = "StorageRead"
  }

  enabled_log {
    category = "StorageWrite"
  }

  enabled_log {
    category = "StorageDelete"
  }
}

resource "azurerm_monitor_diagnostic_setting" "storage_file" {
  name                       = "diag-base"
  target_resource_id         = "${azurerm_storage_account.this.id}/fileServices/default"
  log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id

  enabled_log {
    category = "StorageRead"
  }

  enabled_log {
    category = "StorageWrite"
  }

  enabled_log {
    category = "StorageDelete"
  }
}

resource "azurerm_monitor_diagnostic_setting" "storage_queue" {
  name                       = "diag-base"
  target_resource_id         = "${azurerm_storage_account.this.id}/queueServices/default"
  log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id

  enabled_log {
    category = "StorageRead"
  }

  enabled_log {
    category = "StorageWrite"
  }

  enabled_log {
    category = "StorageDelete"
  }
}

resource "azurerm_monitor_diagnostic_setting" "storage_table" {
  name                       = "diag-base"
  target_resource_id         = "${azurerm_storage_account.this.id}/tableServices/default"
  log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id

  enabled_log {
    category = "StorageRead"
  }

  enabled_log {
    category = "StorageWrite"
  }

  enabled_log {
    category = "StorageDelete"
  }
}
