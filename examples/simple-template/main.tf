# ----------------------------------------------------------------------------
# TEST RESOURCES
# These resources are directly tested.
# ----------------------------------------------------------------------------
locals {
  message = "Hello terraform-kitchen template"

}

module "simple-template" {
  source = "../../"

  message = local.message
}
