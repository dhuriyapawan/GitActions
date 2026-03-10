resource "aws_s3_bucket" "my_bucket" {
  bucket = "java-app-bucket-01-${random_id.bucket_suffix.hex}"
  
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}

output "s3_bucket_name" {
  value       = aws_s3_bucket.my_bucket.bucket
  description = "java-app-bucket-01"
}

output "ec2_public_ip" {
  value       = aws_instance.web.public_ip
  description = "The public IP of the EC2 instance"
}