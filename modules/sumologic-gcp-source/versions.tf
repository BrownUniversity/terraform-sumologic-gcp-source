terraform {
  required_version = "~> 1.0"

  required_providers {
    sumologic = {
      source  = "sumologic/sumologic"
      version = ">= 2.9, < 3.0" # set the Sumo Logic Terraform Provider version
    }
  }
}