variable "ami_id" {}
variable "instance_type" {}
variable "sg_name" {}

variable "private_subnet_id" {}
variable "target_group_arn" {}
variable "min_size" { default = 2 }
variable "max_size" { default = 5 }
variable "desired_capacity" { default = 2 }
variable "user_data_file" {}