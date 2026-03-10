terraform {
  backend "s3" {
    bucket = "java-app-bucket-01"
    key = "prod/terraform/tfstate"
    region = "us-east-1"
    dynamodb_table = "uses_lockfile"
    encrypt = true
  }
}

