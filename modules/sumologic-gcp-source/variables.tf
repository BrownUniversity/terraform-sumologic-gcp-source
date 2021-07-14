#
### Required Variables
#

variable "source_name" {
  description = "Name to use for the source"
  type        = string
}

variable "sumologic_collector_id" {
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
