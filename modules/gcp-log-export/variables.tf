# Required Variables

variable "name" {
  description = "Name to use uniformally for the log source, pubsub topic, and pubsub subscription"
  type        = string
}

variable "sumologic_collector_id" {
  description = "ID of the hosted collector at sumologic that will recieve messages for the new source"
  type        = string
}

variable "project_id" {
  description = "GCP Project ID where the GCP resources should be created"
  type = string
}

variable "sumologic_access_id" {
    type = string
    description = "Sumo Logic Access ID"
}
variable "sumologic_access_key" {
    type = string
    description = "Sumo Logic Access Key"
    sensitive = true
}

# Optional Variables

variable "description" {
  description = "Description of the source"
  type        = string
  default     = null
}

variable "category_delimiter" {
  description = "Delimeter used by sumologic instance for data partition marking"
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
  type        = list(map(string))
  default     = []
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

variable "sumologic_environment" {
  description = "ID of the instance your sumologic instance is in"
  type = string
  default = "us2"
}
