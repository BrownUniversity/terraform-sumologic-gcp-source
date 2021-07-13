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

#
### Required Variables
#

variable "source_name" {
  description = "Name to use for the source"
  type        = string
}

variable "collector_id" {
  description = "ID of the hosted collector that the source will be created under"
  type        = string
}

#
### Optional Variables
#

variable "source_description" {
  description = "Description to use for the source"
  type        = string
  default     = ""
}

variable "category" {
  description = "Single-word category that logs for this search will go into. Will be concated with parent_categories"
  type        = string
  default     = ""
}

variable "parent_categories" {
  description = "A hierarchy of terms that make up the parent categories. Important if using search partitioning"
  type        = list(string)
  default     = []
}

variable "category_delimiter" {
  description = "A character used consistently in your sumologic instance for partition separation."
  type        = string
  default     = "_"
}

variable "filters" {
  description = "A list of the processing rules to add to the sumologic source. Requires an object with name, filter type (Exclude, Include, Mask, Hash, or Forward), and regexp"
  type = list(object({
    name        = string
    filter_type = string
    regexp      = string
  }))
  default = []
}

variable "environment" {
  description = "Location of your sumologic instance"
  type        = string
  default     = "us2"
}

output "id" {
  value = sumologic_gcp_source.sgc.id
}

output "name" {
  value = sumologic_gcp_source.sgc.name
}

output "url" {
  value = sumologic_gcp_source.sgc.url
}

output "collector_id" {
  value = sumologic_gcp_source.sgc.collector_id
}

output "source_category" {
  value = sumologic_gcp_source.sgc.category
}

output "filters" {
  value = sumologic_gcp_source.sgc.filters
}