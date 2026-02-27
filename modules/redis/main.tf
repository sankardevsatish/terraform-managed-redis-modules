resource "azurerm_managed_redis" "this" {
  name                = var.config.name
  resource_group_name = var.config.resource_group_name
  location            = var.config.location
  sku_name            = var.config.sku_name

  # Common settings
  high_availability_enabled = var.config.high_availability_enabled
  public_network_access     = var.config.public_network_access

  # Optional identity block
  dynamic "identity" {
    for_each = var.config.identity == null ? [] : [var.config.identity]
    content {
      type         = identity.value.type
      identity_ids = try(identity.value.identity_ids, [])
    }
  }

  # Optional CMK block
  dynamic "customer_managed_key" {
    for_each = var.config.customer_managed_key == null ? [] : [var.config.customer_managed_key]
    content {
      key_vault_key_id          = customer_managed_key.value.key_vault_key_id
      user_assigned_identity_id = customer_managed_key.value.user_assigned_identity_id
    }
  }

  # Optional default database config
  dynamic "default_database" {
    for_each = var.config.default_database == null ? [] : [var.config.default_database]
    content {
      geo_replication_group_name         = try(default_database.value.geo_replication_group_name, null)
      clustering_policy                  = try(default_database.value.clustering_policy, null)
      eviction_policy                    = try(default_database.value.eviction_policy, null)
      access_keys_authentication_enabled = try(default_database.value.access_keys_authentication_enabled, null)
      client_protocol                    = try(default_database.value.client_protocol, null)
    }
  }

  # Optional Redis feature modules 
  # dynamic "module" {
  #   for_each = try(var.config.module, [])
  #   content {
  #     name = module.value.name
  #     args = try(module.value.args, [])
  #   }
  # }

  tags = try(var.config.tags, {})

}





