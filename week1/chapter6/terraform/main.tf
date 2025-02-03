locals {
  project_name = "de-zoomcamp-2025-449815"
  region_name  = "asia-northeast3"
}

provider "google" {
  project = local.project_name
  region  = local.region_name
}


resource "google_storage_bucket" "demo-bucket" {
  name          = "${local.project_name}-bucket"
  location      = local.region_name
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}
