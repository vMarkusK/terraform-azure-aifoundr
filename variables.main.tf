# General
variable "subscription_id" {
  description = "Subscription ID for all resources"
  type        = string
}

variable "location" {
  description = "Location for all resources"
  type        = string
  default     = "germanywestcentral"
}

variable "env" {
  description = "Environment Name"
  type        = string
}

variable "usecase" {
  description = "Use Case Name"
  type        = string
}

# AI Foundry module inputs (centralized)
variable "ai_foundry_create_byor" {
  description = "Whether to create BYOR resources for AI Foundry"
  type        = bool
  default     = true
}

variable "ai_foundry_create_private_endpoints" {
  description = "Whether to create private endpoints for AI Foundry"
  type        = bool
  default     = false
}

variable "ai_model_deployments" {
  description = "Map of AI model deployments to create"
  type        = map(any)
  default = {
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
}

variable "ai_projects" {
  description = "Map of AI projects and their configuration"
  type        = map(any)
  default = {
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
}

variable "ai_search_definition" {
  description = "AI Search definition per project"
  type        = map(any)
  default     = { this = { enable_diagnostic_settings = false } }
}

variable "cosmosdb_definition" {
  description = "Cosmos DB definition per project"
  type        = map(any)
  default     = { this = { enable_diagnostic_settings = false } }
}

variable "key_vault_definition" {
  description = "Key Vault definition per project"
  type        = map(any)
  default     = { this = { enable_diagnostic_settings = false } }
}

variable "storage_account_definition" {
  description = "Storage Account definition per project"
  type        = map(any)
  default     = { this = { enable_diagnostic_settings = false } }
}
