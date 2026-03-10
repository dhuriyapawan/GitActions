resource "aws_instance" "web" {
  ami           = "ami-0aaa636894689fa47" # Amazon Linux 2 in us-east-1
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private_1.id
  security_groups = [aws_security_group.app_sg.name]

  tags = {
    Name = "web-instance"
  }
}

resource "aws_autoscaling_group" "app_asg" {
  desired_capacity     = 1
  max_size             = 2
  min_size             = 1
  vpc_zone_identifier  = [aws_subnet.private_1.id, aws_subnet.private_2.id]
  launch_template {
    id      = aws_launch_template.web_lt.id
    version = "$Latest"
  }
}

resource "aws_launch_template" "web_lt" {
  name_prefix   = "web-lt-"
  image_id      = "ami-0aaa636894689fa47"
  instance_type = "t2.micro"
  network_interfaces {
    security_groups = [aws_security_group.app_sg.id]
    associate_public_ip_address = false
  }
}