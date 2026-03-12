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

module "iam" {
  source                = "./modules/iam"
  role_name             = "java-app-role"
  instance_profile_name = "java-app-profile"
  policy_arn            = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

module "alb" {
  source         = "./modules/alb"
  lb_name        = "java-app-lb"
  tg_name        = "java-app-tg"
  sg_id          = module.security.sg_id
  public_subnets = [module.vpc.public_subnet_id]
  vpc_id         = module.vpc.vpc_id
}

module "ec2" {
  source               = "./modules/ec2"
  ami_id               = "ami-0c94855ba95c71c99"
  instance_type        = "t3.micro"
  sg_name              = module.security.sg_id
  iam_instance_profile = module.iam.instance_profile_name
  private_subnet_id    = module.vpc.private_subnet_id
  target_group_arn     = module.alb.target_group_arn
  user_data_file       = "user_data.sh"
}

resource "aws_s3_bucket" "example" {
  bucket = var.s3_bucket_name
  acl    = "private"
}