module "ai_foundry" {
  source  = "Azure/avm-ptn-aiml-ai-foundry/azurerm//examples/standard-public"
  version = "0.6.0"

  base_name                  = var.usecase
  location                   = azurerm_resource_group.this.location
  resource_group_resource_id = azurerm_resource_group.this.id

  ai_foundry = {
    create_ai_agent_service = false
    name                    = module.naming.cognitive_account.name_unique
  }

  ai_model_deployments = {
    "gpt-4o" = {
      name = "gpt-4.1"
      model = {
        format  = "OpenAI"
        name    = "gpt-4.1"
        version = "2025-04-14"
      }
      scale = {
        type     = "GlobalStandard"
        capacity = 1
      }
    }
  }

  ai_projects = {
    project_1 = {
      name                       = "playground"
      description                = "Markus AI Playground"
      display_name               = "Markus AI Playground"
      create_project_connections = true
      cosmos_db_connection = {
        new_resource_map_key = "this"
      }
      ai_search_connection = {
        new_resource_map_key = "this"
      }
      storage_account_connection = {
        new_resource_map_key = "this"
      }
    }
  }

  ai_search_definition = {
    this = {
      enable_diagnostic_settings = false
    }
  }

  cosmosdb_definition = {
    this = {
      enable_diagnostic_settings = false
    }
  }

  create_byor              = true
  create_private_endpoints = false # default: false

  key_vault_definition = {
    this = {
      enable_diagnostic_settings = false
    }
  }

  storage_account_definition = {
    this = {
      enable_diagnostic_settings = false
    }
  }

  #depends_on = [azapi_resource_action.purge_ai_foundry]
}

# resource "azapi_resource_action" "purge_ai_foundry" {
#   method      = "DELETE"
#   resource_id = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/providers/Microsoft.CognitiveServices/locations/${azurerm_resource_group.this.location}/resourceGroups/${azurerm_resource_group.this.name}/deletedAccounts/${module.naming.cognitive_account.name_unique}"
#   type        = "Microsoft.Resources/resourceGroups/deletedAccounts@2021-04-30"
#   when        = "destroy"
# }