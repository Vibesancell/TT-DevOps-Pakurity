resource "google_iam_workload_identity_pool" "github_actions" {
  provider                  = google-beta
  project                   = var.project
  workload_identity_pool_id = "github-actions-tt"
  display_name              = "GitHub Actions pool"
  description               = "Workload Identity Pool managed by Terraform"
  disabled                  = false
}

resource "google_iam_workload_identity_pool_provider" "github_actions" {
  provider                           = google-beta
  project                            = var.project
  workload_identity_pool_id          = google_iam_workload_identity_pool.github_actions.workload_identity_pool_id
  workload_identity_pool_provider_id = "github-actions-tt"
  display_name                       = "GitHub Actions provider"
  description                        = "Workload Identity Pool Provider managed by Terraform"
  attribute_condition                = "attribute.repository_owner==\"${var.repo_owner}\""
  attribute_mapping                  = {
    "google.subject"             = "assertion.sub"
    "attribute.actor"            = "assertion.actor"
    "attribute.aud"              = "assertion.aud"
    "attribute.repository"       = "assertion.repository"
    "attribute.repository_owner" = "assertion.repository_owner"
  }
  oidc {
    allowed_audiences = []
    issuer_uri        = "https://token.actions.githubusercontent.com"
  }
}

resource "google_service_account" "tt_devops" {
  account_id   = var.account_id
  display_name = var.display_name
  description  = var.description
}


resource "google_service_account_iam_member" "wif_sa" {
  service_account_id = "projects/${var.project}/serviceAccounts/${google_service_account.tt_devops.email}"
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github_actions.name}/*"
}

resource "google_project_iam_binding" "sa_iam" {
  project = var.project
  role    = "roles/iam.serviceAccountTokenCreator"
  members = [
    "serviceAccount:${google_service_account.deployer.email}",
  ]
}


resource "google_project_iam_member" "this" {
  for_each = toset(var.roles)
  project = var.project
  member  = "serviceAccount:${google_service_account.tt_devops.email}"
  role    = each.value
}