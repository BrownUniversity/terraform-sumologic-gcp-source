# ----------------------------------------------------------------------------
# TEST RESOURCES
# These resources are directly tested.
# ----------------------------------------------------------------------------

locals {
  name = "inspec-sumologic-gcp-source"
}

# ------------------------------------------------------------
#   MAIN BLOCK
# ------------------------------------------------------------

resource "random_string" "resource" {
  length  = 4
  special = false
  upper   = false
}

module "sumologic_gcp_source" {
  source             = "../../modules/sumologic-gcp-source"
  source_name        = local.name
  collector_id       = var.sumologic_collector_id
  source_description = "Test GCP Source"
  category           = "test"
  parent_categories  = ["inspec", "automated"]
}

variable "sumologic_collector_id" {}
