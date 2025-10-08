// Outputs from the inlined ai_foundry module
// These outputs match the original external module outputs that the
// root configuration referenced. They provide compatibility so
// replacing `source = "Azure/..."` is straightforward.

output "name_unique" {
  description = "Base unique name for the inlined module"
  value       = azurerm_cognitive_account.this.name
}

output "cognitive_account_name" {
  description = "Cognitive account name"
  value       = azurerm_cognitive_account.this.name
}

output "storage_account_name" {
  value = azurerm_storage_account.this.name
}

output "key_vault_name" {
  value = azurerm_key_vault.this.name
}

output "cosmosdb_account_name" {
  value = azurerm_cosmosdb_account.this.name
}

// Aggregate output to mark several optional inputs as used and to
// provide a compact debugging/compatibility view of what the module
// received. This prevents linter warnings about unused variables and
// helps when extending the module later.
output "module_info" {
  description = "Debugging map that contains configured options passed to the inlined module"
  value = {
    ai_foundry                 = try(var.ai_foundry, {})
    ai_model_deployments       = try(var.ai_model_deployments, {})
    ai_projects                = try(var.ai_projects, {})
    ai_search_definition       = try(var.ai_search_definition, {})
    cosmosdb_definition        = try(var.cosmosdb_definition, {})
    create_byor                = try(var.create_byor, null)
    create_private_endpoints   = try(var.create_private_endpoints, null)
    key_vault_definition       = try(var.key_vault_definition, {})
    storage_account_definition = try(var.storage_account_definition, {})
  }
}
