resource "google_storage_bucket" "aum_bucket" {
  name = "aum-github-bucket"
  location = "US"
  force_destroy = true
  public_access_prevention = "enforced"
}