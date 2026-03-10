terraform {
  backend "s3" {
    bucket = "java-app-bucket-01"
    key = "prod/terraform/tfstate"
    region = "us-east-1"
    use_lockfile = "terraform-lock"
    encrypt = true
  }
}

