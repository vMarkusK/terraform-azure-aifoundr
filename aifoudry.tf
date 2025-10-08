// Inlined local ai_foundry module replaces external module source to make
// the repository self-contained. The local module implements the
// subset of resources and outputs used by the root configuration.
module "ai_foundry" {
  source = "./modules/ai_foundry"

  rg_name  = azurerm_resource_group.this.name
  location = azurerm_resource_group.this.location

  tags = local.tags

  cognitive_account_name = module.naming.cognitive_account.name_unique
  storage_account_name   = module.naming.storage_account.name_unique
  ccosmosdb_account_name = module.naming.cosmosdb_account.name_unique

  ai_foundry = {
    create_ai_agent_service = false
    name                    = module.naming.cognitive_account.name_unique
  }
  ai_model_deployments = var.ai_model_deployments
  ai_projects          = var.ai_projects
  ai_search_definition = var.ai_search_definition
  cosmosdb_definition  = var.cosmosdb_definition

  create_byor              = var.ai_foundry_create_byor
  create_private_endpoints = var.ai_foundry_create_private_endpoints

  key_vault_definition       = var.key_vault_definition
  storage_account_definition = var.storage_account_definition

  depends_on = [azapi_resource_action.purge_ai_foundry]
}

resource "azapi_resource_action" "purge_ai_foundry" {
  method      = "DELETE"
  resource_id = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/providers/Microsoft.CognitiveServices/locations/${azurerm_resource_group.this.location}/resourceGroups/${azurerm_resource_group.this.name}/deletedAccounts/${module.naming.cognitive_account.name_unique}"
  type        = "Microsoft.Resources/resourceGroups/deletedAccounts@2021-04-30"
  when        = "destroy"
}