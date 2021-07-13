# Temporarily disable the org policy domain restricted sharing
resource "google_project_organization_policy" "domain_restricted_sharing_disable" {
  project = var.project_id
  constraint = "iam.allowedPolicyMemberDomains"

  list_policy {
    allow {
      all = true
    }
  }
  lifecycle {
    ignore_changes = all
  }
}

# Restore the org policy domain restricted sharing once the depends_on resources are fully resolved
# Referencing a domain constraint without any config blocks (as done here) changes the config to "inherit from parent", which is desired here
resource "google_project_organization_policy" "domain_restricted_sharing_enable" {
  depends_on = [google_pubsub_topic_iam_member.member, google_pubsub_subscription.push, google_logging_project_sink.logged_messages]
  project = var.project_id
  constraint = "iam.allowedPolicyMemberDomains"
  lifecycle {
    ignore_changes = all
  }
}

# Work around the amount of time required for the policy change to register in the project after disabling DRS policy
resource "time_sleep" "wait_30_seconds" {
  depends_on = [google_project_organization_policy.domain_restricted_sharing_disable]
  create_duration = "60s"
}

# Create the pubsub topic
resource "google_pubsub_topic" "topic" {
  name = var.name
  project = var.project_id
}

# Create a log router to the topic
resource "google_logging_project_sink" "logged_messages" {
  for_each = var.gcp_filters
  name = "${each.key}-logs"
  project = var.project_id
  # Send the filtered messages to the topic we created
  destination = "pubsub.googleapis.com/${google_pubsub_topic.topic.id}"

  # filter for the logged message
  filter = each.value
}

# While the DRS policy is disabled, alter the permissions on the topic to allow the log agent to publish to the topic.
resource "google_pubsub_topic_iam_member" "member" {
  depends_on = [time_sleep.wait_30_seconds]
  for_each = google_logging_project_sink.logged_messages
  project = var.project_id
  topic = google_pubsub_topic.topic.name
  role = "roles/pubsub.publisher"
  member = var.pubsub_sa_publisher_account
}

# Create the pubsub subscription to push logs to the sumologic URL endpoint
resource "google_pubsub_subscription" "push" {
  name  = "${var.name}-push"
  project = var.project_id
  topic = google_pubsub_topic.topic.name

  ack_deadline_seconds = var.push_deadline_seconds

  push_config {
    push_endpoint = sumologic_gcp_source.gcp_pubsub.url

    attributes = {
      x-goog-version = "v1"
    }
  }
}