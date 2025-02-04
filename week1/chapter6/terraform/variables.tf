variable "project" {
  description = "Project"
  default     = "de-zoomcamp-2025-449815"
}


variable "region" {
  description = "Region"
  default     = "asia-northeast3"
}


variable "location" {
  description = "Project Location"
  default     = "asia-northeast3"
}


variable "bq_dataset_name" {
  description = "My BigQuery Dataset Name"
  default     = "demo_dataset"
}

variable "gcs_bucket_name" {
  description = "My Storage Bucket Name"
  default     = "de-zoomcamp-2025-449815-bucket"
}


variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}


