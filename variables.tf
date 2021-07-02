# Required Variables

variable "name" {
  description = "Name to use uniformally for the log source, pubsub topic, and pubsub subscription"
  type        = string
}

variable "sumologic_collector_id" {
  description = "ID of the hosted collector at sumologic that will recieve messages for the new source"
  type        = string
}

# Optional Variables

variable "description" {
  description = "Description of the source"
  type        = string
  default     = null
}

variable "category_delimiter" {
  description = "Delimeter used by org for splitting categories"
  type        = string
  default     = "_"
}

variable "parent_categories" {
  description = "Source categories for the log source. Used to group logs through use of deliminters (-,/,etc)"
  type        = list(string)
  default     = ["gcp"]
}

variable "source_category" {
  description = "Source category for the log source. Used to group logs through use of deliminters (-,/,etc)"
  type        = string
  default     = null
}

variable "sumologic_filters" {
  description = "List of regex filters to apply to source at collector ingest"
  type        = list(string)
  default     = []
}

variable "pubsub_push_filter" {
  description = "Cause the subscription to only deliver messages that match the filter. Cannot be changed after creation"
  type        = string
  default     = null
}

variable "sumologic_environment" {
  description = "ID of the instance your sumologic instance is in"
  type = string
  default = "us2"
}
