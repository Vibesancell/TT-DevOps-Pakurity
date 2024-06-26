variable "project_id" {
  description = "The ID of the project in which to create the dataset and table."
  type        = string
}

variable "region" {
  description = "The region in which to create the dataset and table."
  type        = string
}

variable "dataset_id" {
  description = "The ID of the BigQuery dataset."
  type        = string
}

variable "dataset_location" {
  description = "The location of the BigQuery dataset."
  type        = string
}

variable "table_id" {
  description = "The ID of the BigQuery table."
  type        = string
}