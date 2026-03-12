output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_id" {
  value = module.vpc.public_subnet_id
}

output "private_subnet_id" {
  value = module.vpc.private_subnet_id
}

output "sg_id" {
  value = module.security.sg_id
}

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "ec2_asg_name" {
  value = module.ec2.asg_name
}