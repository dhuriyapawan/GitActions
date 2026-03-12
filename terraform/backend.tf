terraform {
  backend "s3" {
    bucket         = "java-app-bucket-01"
    key            = "java-app-bucket-01/terraform.tfstate"
    region         = "eu-north-1"
    use_lockfile = true
  }
}