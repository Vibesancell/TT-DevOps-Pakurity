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

###### Create null_recource for auto field table ######
resource "null_resource" "big_query" {
  provisioner "local-exec" {
    working_dir = "${path.module}/../../modules/big_query/script"
    command     = "python3 -m venv venv && source venv/bin/activate && pip install google-cloud-bigquery google-auth && python3 insert_rows.py"
    interpreter = ["bash", "-c"]
  }

  triggers = {
    rerun_every_time = timestamp()
  }
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
            "roles/iam.workloadIdentityPoolAdmin",
            "roles/iam.workloadIdentityUser"
          ]
}

module "big_query" {
  source = "../../modules/big_query"

  table_id = "${local.environment}_${local.app_name}_table"
  project_id = local.project
  dataset_id = "${local.environment}_${local.app_name}_dataset"
  region = local.region
  dataset_location = "US"
}