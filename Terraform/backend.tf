terraform {
  backend "s3" {
    bucket = "java-app-bucket-01"
    key = "prod/terraform/tfstate"
    region = "eu-north-1"
    use_lockfile = true
    encrypt = true
  }
}

