module "vpc" {
  source        = "./modules/vpc"
  vpc_cidr      = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}

module "security_groups" {
  source = "./modules/security-group"
  vpc_id = module.vpc.vpc_id
}

module "alb" {
  source          = "./modules/alb"
  public_subnets  = module.vpc.public_subnets
  security_groups = [module.security_groups.alb_sg_id]
  vpc_id          = module.vpc.vpc_id
}

module "backend_ec2" {
  source          = "./modules/ec2"
  ami             = var.ami
  instance_type   = var.instance_type
  private_subnets = module.vpc.private_subnets
  security_groups = [module.security_groups.backend_sg_id]
  docker_image    = var.java_app_docker_image
}

resource "aws_lb_target_group_attachment" "backend" {
  count            = length(module.backend_ec2.instance_ids)
  target_group_arn = module.alb.target_group_arn
  target_id        = module.backend_ec2.instance_ids[count.index]
  port             = 8080
}

output "alb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = module.alb.alb_dns_name
}