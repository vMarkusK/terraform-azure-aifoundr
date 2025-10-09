resource "azurerm_key_vault" "this" {
  name                = module.naming.key_vault.name_unique
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  tags                = local.tags

  sku_name                   = "standard"
  tenant_id                  = data.azuread_client_config.current.tenant_id
  rbac_authorization_enabled = true
  purge_protection_enabled   = true
  soft_delete_retention_days = 7

  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
    ip_rules       = [var.trusted_ip]
  }

}

resource "azurerm_role_assignment" "cryptouser" {
  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Crypto User"
  principal_id         = azurerm_user_assigned_identity.this.principal_id
  principal_type       = "ServicePrincipal"
}

#trivy:ignore:AVD-AZU-0014
resource "azurerm_key_vault_key" "this" {
  name         = module.naming.key_vault_key.name_unique
  key_vault_id = azurerm_key_vault.this.id
  tags         = local.tags

  # As of 10/2025 Foundry only supports 2048 bit keys
  key_type = "RSA"
  key_size = 2048
  key_opts = ["decrypt", "encrypt", "sign", "verify", "wrapKey", "unwrapKey"]

  expiration_date = timeadd(formatdate("YYYY-MM-DD'T'HH:mm:ss'Z'", time_static.current.rfc3339), "8760h")

  rotation_policy {
    automatic {
      time_before_expiry = "P60D"
    }

    expire_after         = "P365D"
    notify_before_expiry = "P30D"
  }

  lifecycle {
    ignore_changes = [expiration_date]
  }
}