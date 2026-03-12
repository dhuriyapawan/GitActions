module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
  vpc_name            = "java-app-vpc"
  az                  = "us-east-1a"
}

module "security" {
  source  = "./modules/security"
  vpc_id  = module.vpc.vpc_id
  sg_name = "java-app-sg"
}


module "alb" {
  source         = "./modules/alb"
  lb_name        = "java-app-lb"
  tg_name        = "java-app-tg"
  sg_id          = module.security.sg_id
  public_subnets = [module.vpc.public_subnet_id]
  vpc_id         = module.vpc.vpc_id
}



resource "aws_s3_bucket" "example" {
  bucket = var.s3_bucket_name
  acl    = "private"
}