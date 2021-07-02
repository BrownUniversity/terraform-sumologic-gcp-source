output "source_category_string" {
  value = "${local.parent_categories}${local.category}"
}

output "sumologic_source_id" {
  value = sumologic_gcp_source.gcp_pubsub.id
}

output "google_pubsub_topic_id" {
  value = google_pubsub_topic.topic.id
}

output "google_pubsub_subscription_id" {
  value = google_pubsub_subscription.push.id
}