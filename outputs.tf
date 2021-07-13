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

output "sumologic_endpoint" {
  value = module.sumologic-gcp-source.url
}