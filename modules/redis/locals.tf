locals {
  # Standard enterprise tags (these apply everywhere)
  standard_tags = {
    ManagedBy   = "Terraform"
    Component   = "managed-redis"
  }

  # Merge standard tags + caller tags (caller wins if duplicate)
  merged_tags = merge(local.standard_tags, var.config.tags)
}
