locals {
  project = "tt-devops-427513"  
  app_name = "tt-devops"
  environment = "prod"
  region   = "us-central1"
  zone     = "us-central1-a"

  services = toset([
    # MUST-HAVE for GitHub Actions setup
    "iam.googleapis.com",                  # Identity and Access Management (IAM) API
    "iamcredentials.googleapis.com",       # IAM Service Account Credentials API
    "cloudresourcemanager.googleapis.com", # Cloud Resource Manager API
    "sts.googleapis.com",                  # Security Token Service API
  ])
}