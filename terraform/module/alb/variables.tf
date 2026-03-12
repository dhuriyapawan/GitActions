variable "lb_name" {}
variable "tg_name" {}
variable "sg_id" {}
variable "public_subnets" { type = list(string) }
variable "vpc_id" {}