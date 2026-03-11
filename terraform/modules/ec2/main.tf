resource "aws_instance" "backend" {
  count                = length(var.private_subnets)
  ami                  = var.ami
  instance_type        = var.instance_type
  subnet_id            = var.private_subnets[count.index]
  vpc_security_group_ids = var.security_groups

  user_data = <<EOF
#!/bin/bash
amazon-linux-extras install docker -y
service docker start
docker run -d -p 8080:8080 ${var.docker_image}
EOF

  tags = {
    Name = "java-backend-${count.index + 1}"
  }
}
