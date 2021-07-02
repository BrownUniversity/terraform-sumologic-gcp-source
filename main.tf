locals {
  parent_categories = join(var.category_delimiter, var.parent_categories)
  category          = var.source_category != null ? "${var.category_deliminter}${var.source_category}" : null
}

resource "sumologic_gcp_source" "gcp_pubsub" {
  name         = var.name
  description  = var.description
  category     = "${local.parent_categories}${local.category}"
  collector_id = var.sumologic_collector_id
  filters      = var.sumologic_filters
}

resource "google_pubsub_topic" "topic" {
  name = var.name
}

resource "google_pubsub_subscription" "push" {
  name  = "${var.name}_push"
  topic = google_pubsub_topic.topic.name

  ack_deadline_seconds = 20

  push_config {
    push_endpoint = sumologic_gcp_source.gcp_pubsub.url

    attributes = {
      x-goog-version = "v1"
    }
  }
  filter = var.pubsub_push_filter
}

