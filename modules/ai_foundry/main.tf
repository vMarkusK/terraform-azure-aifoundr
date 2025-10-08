// Inlined ai_foundry core resources
// This is a compact, local implementation of the external AVM module's
// core resources used by the root configuration. It intentionally
// implements minimal resource shapes (cognitive account, storage,
// cosmosdb, keyvault) and exposes outputs expected by the root.

locals {
  // base for resource names following AVM style
  name_prefix = var.base_name
}

// Use a random suffix to keep names unique (similar to AVM naming)
resource "random_id" "suffix" {
  byte_length = 3
}

// Cognitive Services account (represents AI Foundry cognitive account)
resource "azurerm_cognitive_account" "this" {
  name                = "${local.name_prefix}-cog-${random_id.suffix.hex}"
  location            = var.location
  resource_group_name = split("/", var.resource_group_resource_id)[length(split("/", var.resource_group_resource_id)) - 1]
  kind                = "CognitiveServices"
  sku_name            = "S0"

  tags = var.tags
}

// Storage account used for the AI project artifacts
resource "azurerm_storage_account" "this" {
  name                     = replace(lower("${local.name_prefix}st${random_id.suffix.hex}"), "-", "")
  resource_group_name      = split("/", var.resource_group_resource_id)[length(split("/", var.resource_group_resource_id)) - 1]
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.tags
}

// Key Vault placeholder
resource "azurerm_key_vault" "this" {
  name                       = "${local.name_prefix}-kv-${random_id.suffix.hex}"
  location                   = var.location
  resource_group_name        = split("/", var.resource_group_resource_id)[length(split("/", var.resource_group_resource_id)) - 1]
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

// Cosmos DB account placeholder
resource "azurerm_cosmosdb_account" "this" {
  name                = "${local.name_prefix}-cos-${random_id.suffix.hex}"
  location            = var.location
  resource_group_name = split("/", var.resource_group_resource_id)[length(split("/", var.resource_group_resource_id)) - 1]
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

// Minimal representation of AI model deployments and projects as local
// resources (these are logical placeholders so existing root
// references continue to work). In complex setups these would be
// implemented with `azapi_resource` or provider-specific resources.

locals {
  model_deployments = var.ai_model_deployments
  projects          = var.ai_projects
}
