output "id" {
  value = azurerm_managed_redis.this.id
}

output "name" {
  value = azurerm_managed_redis.this.name
}

output "resource_group_name" {
  value = azurerm_managed_redis.this.resource_group_name
}

# output "primary_access_key" {
#   value     = azurerm_managed_redis.this.primary_access_key
#   sensitive = true
# }

