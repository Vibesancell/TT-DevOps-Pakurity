resource "google_project_service" "service" {
  for_each = local.services
  project  = local.project
  service  = each.value
}