# outputs.tf

output "s3_bucket_name" {
  value       = aws_s3_bucket.my_bucket.bucket
  description = "The name of the S3 bucket"
}

output "vpc_id" {
  value       = aws_vpc.main.id
  description = "The ID of the main VPC"
}

output "ec2_public_ip" {
  value       = aws_instance.web.public_ip
  description = "The public IP of the EC2 instance"
}