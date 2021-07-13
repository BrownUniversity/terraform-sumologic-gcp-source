output "source_category_string" {
  value = "${local.parent_categories}${local.category}"
}

output "sumologic_collector_id" {
  value = sumologic_gcp_source.gcp_pubsub.collector_id
}

output "sumologic_source_id" {
  value = sumologic_gcp_source.gcp_pubsub.id
}

output "sumologic_source_name" {
  value = sumologic_gcp_source.gcp_pubsub.name
}

output "sumologic_endpoint" {
  value = sumologic_gcp_source.gcp_pubsub.url
}

output "google_pubsub_topic_id" {
  value = google_pubsub_topic.topic.id
}

output "google_pubsub_topic_name" {
  value = google_pubsub_topic.topic.name
}

output "google_pubsub_subscription_id" {
  value = google_pubsub_subscription.push.id
}

output "google_pubsub_subscription_shortid" {
  value = google_pubsub_subscription.push.name
}

output "google_pubsub_subscription_name" {
  value = google_pubsub_subscription.push.name
}

output "google_topic_iam_publisher" {
  value = one(distinct(values(google_pubsub_topic_iam_member.member)[*].member))
}