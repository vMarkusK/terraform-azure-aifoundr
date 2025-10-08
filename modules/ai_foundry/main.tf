// Cognitive Services account (represents AI Foundry cognitive account)
resource "azurerm_cognitive_account" "this" {
  name                = var.cognitive_account_name
  location            = var.location
  resource_group_name = var.rg_name
  kind                = "CognitiveServices"
  sku_name            = "S0"

  tags = var.tags
}

// Key Vault
resource "azurerm_key_vault" "this" {
  name                       = "${local.name_prefix}-kv-${random_id.suffix.hex}"
  location                   = var.location
  resource_group_name        = var.rg_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  purge_protection_enabled   = false
  soft_delete_retention_days = 7

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = ["get", "list"]
  }

  tags = var.tags
}

// Storage account used for the AI project artifacts
resource "azurerm_storage_account" "this" {
  name                     = var.storage_account_name
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.tags
}

// Cosmos DB account
resource "azurerm_cosmosdb_account" "this" {
  name                = var.cosmosdb_account_name
  location            = var.location
  resource_group_name = var.rg_name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"
  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = var.location
    failover_priority = 0
  }

  tags = var.tags
}