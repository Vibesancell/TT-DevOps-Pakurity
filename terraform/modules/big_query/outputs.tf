output "bigquery_dataset_id" {
  value = google_bigquery_dataset.dataset.dataset_id
}

output "bigquery_table_id" {
  value = google_bigquery_table.table.table_id
}

output "bigquery_table_self_link" {
  value = google_bigquery_table.table.self_link
}