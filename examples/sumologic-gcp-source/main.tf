# ----------------------------------------------------------------------------
# TEST RESOURCES
# These resources are directly tested.
# ----------------------------------------------------------------------------

resource "random_id" "res" {
  byte_length = 2
}

module "simple-project" {
  source = "../../"

  project_name    = local.project_name
  billing_account = var.billing_account
  folder_id       = var.folder_id
}

module "gcp_sumologic_source" {
  source = "../"
  name = "Inspec Test ${random_id.res.hex}"
}

output "random" {
  value = random_id.res.hex
}
