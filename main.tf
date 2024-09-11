resource "google_storage_bucket" "aum_bucket" {
  name                     = "aum-github-bucket"
  project                  = "vaibhav-gcp-01-433314-t5"
  location                 = "US"
  force_destroy            = true
  public_access_prevention = "enforced"
}
