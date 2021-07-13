# Required Variables

variable "name" {
  description = "Name to use uniformally for the log source, pubsub topic, and pubsub subscription"
  type        = string
}

variable "project_id" {
  description = "GCP Project ID where the GCP resources should be created"
  type = string
}

variable "sumologic_collector_id" {
  description = "ID of the hosted collector at sumologic that will recieve messages for the new source"
  type        = string
}

# Optional Variables

variable "source_description" {
    description = "Description to use for the source"
    type = string
    default = ""
}

variable "category" {
    description = "Single-word category that logs for this search will go into. Will be concated with parent_categories"
    type = string
    default = ""
}

variable "parent_categories" {
    description = "A hierarchy of terms that make up the parent categories. Important if using search partitioning"
    type = list(string)
    default = []
}

variable "gcp_filters" {
  description = "List of map of filters to create and be routed into the pubsub topic and push"
  type        = map(string)
  default     = {}
}

variable "push_deadline_seconds" {
  description = "Maximum amount of time for the subscription to wait for acknowledgement of reciept of message"
  type = number
  default = 20
}

# You probably shouldn't change this, but it's here if you know a specific use case
variable "pubsub_sa_publisher_account" {
  description = "GCP Service Account to assign roles/pubsub.publisher to."
  type = string
  default = "serviceAccount:cloud-logs@system.gserviceaccount.com"
}