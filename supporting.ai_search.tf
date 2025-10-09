## TODO Encryptin with CMK 
# https://learn.microsoft.com/en-us/azure/templates/microsoft.search/searchservices?pivots=deployment-language-terraform
resource "azapi_resource" "ai_search" {
  type                      = "Microsoft.Search/searchServices@2025-05-01"
  name                      = module.naming.search_service.name_unique
  parent_id                 = azurerm_resource_group.this.id
  location                  = azurerm_resource_group.this.location
  tags                      = local.tags
  schema_validation_enabled = true

  body = {
    sku = {
      name = "standard"
    }

    identity = {
      type = "SystemAssigned"
    }

    properties = {

      replicaCount   = 1
      partitionCount = 1
      hostingMode    = "default"
      semanticSearch = "standard"

      disableLocalAuth = false
      authOptions = {
        aadOrApiKey = {
          aadAuthFailureMode = "http401WithBearerChallenge"
        }
      }

      publicNetworkAccess = "enabled"
      networkRuleSet = {
        bypass = "AzureServices"
        ipRules = [
          {
            value = var.trusted_ip
          }
        ]
      }
    }

  }

  response_export_values = [
    "identity.principalId",
    "properties.customSubDomainName"
  ]
}