resource "google_bigquery_dataset" "dataset" {
  dataset_id = var.dataset_id
  location   = var.dataset_location
}

resource "google_bigquery_table" "table" {
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  table_id   = var.table_id

  schema = <<EOF
[
  {
    "name": "Id",
    "type": "INTEGER",
    "mode": "REQUIRED"
  },
  {
    "name": "Tag",
    "type": "STRING",
    "mode": "REQUIRED"
  },
  {
    "name": "Count",
    "type": "INTEGER",
    "mode": "REQUIRED"
  }
]
EOF
}

# Create BigQuery view
resource "google_bigquery_table" "view" {
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  table_id   = var.view_id

  view {
    query          = <<EOF
    SELECT 
      Tag,
      SUM(Count) as total_count
    FROM 
      `${var.project_id}.${var.dataset_id}.${var.table_id}`
    GROUP BY 
      Tag
    EOF
    use_legacy_sql = false
  }
}