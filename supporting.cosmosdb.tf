## TODO Encryption with CMK
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_account
resource "azurerm_cosmosdb_account" "this" {
  name                = module.naming.cosmosdb_account.name_unique
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  tags                = local.tags

  offer_type        = "Standard"
  kind              = "GlobalDocumentDB"
  free_tier_enabled = false

  local_authentication_disabled = true
  public_network_access_enabled = true

  automatic_failover_enabled       = false
  multiple_write_locations_enabled = false

  #Accept connections from within public Azure datacenters. https://learn.microsoft.com/en-us/azure/cosmos-db/how-to-configure-firewall#allow-requests-from-the-azure-portal
  #Allow access from the Azure portal. https://learn.microsoft.com/en-us/azure/cosmos-db/how-to-configure-firewall#allow-requests-from-global-azure-datacenters-or-other-sources-within-azure
  ip_range_filter = [
    "0.0.0.0",
    "13.91.105.215", "4.210.172.107", "13.88.56.148", "40.91.218.243",
    var.trusted_ip
  ]

  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.this.id
    ]
  }

  key_vault_key_id = azurerm_key_vault_key.this.versionless_id

  consistency_policy {
    consistency_level = "Session"
  }

  # Configure single location with no zone redundancy to reduce costs
  geo_location {
    location          = azurerm_resource_group.this.location
    failover_priority = 0
    zone_redundant    = false
  }

  depends_on = [azurerm_role_assignment.cryptouser]

}