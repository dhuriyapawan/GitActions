variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "region" {
  default = "ap-south-1"
}

variable "ami" {
  default = "ami-0aaa636894689fa47" # Update to latest Amazon Linux 2 AMI
}

variable "instance_type" {
  default = "t3.micro"
}

variable "java_app_docker_image" {
  description = "Docker image for the Java application"
  default     = "amazoncorretto:11" # Example default, user can override
}
