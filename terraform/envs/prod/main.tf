terraform {
  required_version = ">= 1.6.3"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.21.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "5.21.0"
    }

  }
}

provider "google" {
  project     = local.project
  region      = local.region
  zone        = local.zone
}

###### Create custom modules ######
module "identity_federation" {
  source = "../../modules/identity_federation"

  project = local.project
  repo_owner = "Vibesancell"

  account_id   = "tt-devops-sa"
  display_name = "tt-devops"
  description  = "tt-devops github action role"
  roles = [ "roles/storage.objectCreator", 
            "roles/storage.objectViewer",
            "roles/storage.objectAdmin",
            "roles/iam.serviceAccountUser",
            "roles/iam.serviceAccountAdmin",
            "roles/iam.workloadIdentityPoolAdmin"
          ]
}

module "big_query" {
  source = "../../modules/big_query"

  table_id = "${local.environment}_${local.app_name}_table"
  project_id = local.project
  dataset_id = "${local.environment}_${local.app_name}_dataset"
  region = "US"
  dataset_location = local.zone
}