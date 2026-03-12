variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  type    = string
  default = "10.0.2.0/24"
}

variable "availability_zone" {
  type    = string
  default = "us-east-1a"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "java_app_git_repo" {
  type    = string
  default = "https://github.com/your-org/java-app.git"
}

variable "ami_id" {
  type    = string
  default = "ami-0c94855ba95c71c99" # Amazon Linux 2
}

variable "min_asg_size" {
  type    = number
  default = 2
}

variable "max_asg_size" {
  type    = number
  default = 5
}

variable "desired_asg_capacity" {
  type    = number
  default = 2
}
variable "s3_bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}