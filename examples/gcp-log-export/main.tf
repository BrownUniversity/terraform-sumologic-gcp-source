# ----------------------------------------------------------------------------
# TEST RESOURCES
# These resources are directly tested.
# ----------------------------------------------------------------------------

locals {
  gcp_region = "us-east1"
  gcp_zone   = "us-east1-b"
  name       = "inspec-pubsub-test-${random_string.resource.result}"
}

# ------------------------------------------------------------
#   MAIN BLOCK
# ------------------------------------------------------------

resource "random_string" "resource" {
  length  = 4
  special = false
  upper   = false
}

# Create the GCP Project
module "project" {
  source          = "git::https://github.com/BrownUniversity/terraform-gcp-project.git?ref=v0.1.3"
  project_name    = local.name
  org_id          = var.org_id
  billing_account = var.billing_account
  folder_id       = var.folder_id
  activate_apis   = var.activate_apis
}

# Temporarily disable the org policy domain restricted sharing
resource "google_project_organization_policy" "domain_restricted_sharing_disable" {
  project = module.project.project_id
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

module "gcp-log-export" {
  depends_on = [google_project_organization_policy.domain_restricted_sharing_disable]
  source                 = "../.."
  project_id             = module.project.project_id
  sumologic_collector_id = var.sumologic_collector_id
  name                   = local.name
  gcp_filters = {
    gke     = "resource.type=\"gke_cluster\" OR resource.type=\"k8s_cluster\" OR resource.type=\"k8s_node\" OR resource.type=\"k8s_pod\"",
    project = "resource.type=\"project\""
  }
}

variable "sumologic_collector_id" {}
variable "folder_id" {}
variable "org_id" {}
variable "billing_account" {}
variable "activate_apis" { default = ["pubsub.googleapis.com"] }