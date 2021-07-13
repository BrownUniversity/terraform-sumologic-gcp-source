# Use the included submodule to create the sumologic source
module "sumologic-gcp-source" {
  source             = "./modules/sumologic-gcp-source"
  source_name        = var.name
  collector_id       = var.sumologic_collector_id
  source_description = var.source_description
  category           = var.category
  parent_categories  = var.parent_categories
}

# Create the pubsub topic
resource "google_pubsub_topic" "topic" {
  name    = var.name
  project = var.project_id
}

# Create a log router to the topic
resource "google_logging_project_sink" "logged_messages" {
  for_each = var.gcp_filters
  name     = "${each.key}-logs"
  project  = var.project_id
  # Send the filtered messages to the topic we created
  destination = "pubsub.googleapis.com/${google_pubsub_topic.topic.id}"

  # filter for the logged message
  filter = each.value
}

# While the DRS policy is disabled, alter the permissions on the topic to allow the log agent to publish to the topic.
resource "google_pubsub_topic_iam_member" "member" {
  for_each = google_logging_project_sink.logged_messages
  project  = var.project_id
  topic    = google_pubsub_topic.topic.name
  role     = "roles/pubsub.publisher"
  member   = var.pubsub_sa_publisher_account
}

# Create the pubsub subscription to push logs to the sumologic URL endpoint
resource "google_pubsub_subscription" "push" {
  name    = "${var.name}-push"
  project = var.project_id
  topic   = google_pubsub_topic.topic.name

  ack_deadline_seconds = var.push_deadline_seconds

  push_config {
    push_endpoint = module.sumologic-gcp-source.url

    attributes = {
      x-goog-version = "v1"
    }
  }
}