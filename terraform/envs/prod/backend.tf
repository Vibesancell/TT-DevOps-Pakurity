terraform {
  backend "gcs" {
    bucket = "tt-devops-427513-terraform"
    prefix = "production"
  }
}
