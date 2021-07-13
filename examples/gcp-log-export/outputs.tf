output "google_project_id" {
  value = module.project.project_id
}

output "google_pubsub_topic_id" {
  value = module.gcp-log-export.google_pubsub_topic_id
}

output "google_pubsub_topic_name" {
  value = module.gcp-log-export.google_pubsub_topic_name
}

output "google_pubsub_subscription_id" {
  value = module.gcp-log-export.google_pubsub_subscription_id
}

output "google_pubsub_subscription_name" {
  value = module.gcp-log-export.google_pubsub_subscription_name
}

output "google_topic_iam_publisher" {
  value = module.gcp-log-export.google_topic_iam_publisher
}

output "sumologic_endpoint" {
  value = module.gcp-log-export.sumologic_endpoint
}