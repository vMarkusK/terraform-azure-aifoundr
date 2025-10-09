resource "azurerm_storage_account" "this" {
  name                = module.naming.storage_account.name_unique
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  tags                = local.tags

  account_kind             = "StorageV2"
  account_tier             = "Standard"
  access_tier              = "Hot"
  account_replication_type = "LRS"

  public_network_access_enabled    = true
  https_traffic_only_enabled       = true
  min_tls_version                  = "TLS1_2"
  shared_access_key_enabled        = false
  allow_nested_items_to_be_public  = false
  cross_tenant_replication_enabled = false
  sftp_enabled                     = false
  local_user_enabled               = false
  queue_encryption_key_type        = "Account"
  table_encryption_key_type        = "Account"


  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.this.id
    ]
  }

  customer_managed_key {
    key_vault_key_id          = azurerm_key_vault_key.this.id
    user_assigned_identity_id = azurerm_user_assigned_identity.this.id
  }

  network_rules {
    default_action = "Deny"
    bypass         = ["Logging", "Metrics", "AzureServices"]
    ip_rules       = [var.trusted_ip]
  }

  share_properties {
    retention_policy {
      days = 7
    }
  }

  blob_properties {
    container_delete_retention_policy {
      days = 7
    }
  }

  depends_on = [azurerm_role_assignment.cryptouser]
}