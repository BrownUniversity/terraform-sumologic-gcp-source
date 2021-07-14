# Locals - compose a sumologic source category string using your org's partitioning character
locals {
  parent_categories = join(var.category_delimiter, var.parent_categories)
}

# Create the sumologic source for a given sumologic hosted collector
resource "sumologic_gcp_source" "sgc" {
  name         = var.source_name
  description  = var.source_description
  category     = var.category != null ? "${local.parent_categories}${var.category_delimiter}${var.category}" : null
  collector_id = var.collector_id
  dynamic "filters" {
    for_each = var.filters
    content {
      name        = filters.value["name"]
      filter_type = filters.value["filter_type"]
      regexp      = filters.value["regexp"]
    }
  }
}
