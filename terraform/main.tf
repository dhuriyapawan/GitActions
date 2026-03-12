resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  tags = { Name = var.vpc_name }
}

output "vpc_id" {
  value = aws_vpc.this.id
}

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.public_subnet_cidr
  availability_zone = var.az
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}