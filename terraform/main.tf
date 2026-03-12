module "vpc" {
  source          = "./modules/vpc"
  vpc_cidr        = var.vpc_cidr 
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
}

module "backend_ec2" {
  source          = "./modules/ec2"
  ami             = var.ami 
  instance_type   = var.instance_type [cite: 3]
  private_subnets = module.vpc.private_subnets 
  security_groups = [module.security_groups.backend_sg_id] 
  s3_bucket_name  = var.s3_bucket_name
}