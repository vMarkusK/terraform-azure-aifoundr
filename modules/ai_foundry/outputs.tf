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
