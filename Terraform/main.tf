# ==========================================
# 1. Provider
# ==========================================
provider "aws" {
  region = "us-east-1"
}

# ==========================================
# 2. Security Group
# ==========================================
resource "aws_security_group" "web_sg" {
  name        = "web-app-sg"
  description = "Allow HTTP and SSH"
  vpc_id      = "vpc-00ee66507602824e0"  # Replace with your VPC ID

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.2.0/32"]  # Replace with your IP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ==========================================
# 3. Launch Template with WAR deployment
# ==========================================
resource "aws_launch_template" "web_app" {
  name_prefix   = "web-app-"
  image_id      = "ami-02dfbd4ff395f2a1b" # Amazon Linux 2 AMI (update for your region)
  instance_type = "t2.micro"

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y java-11-amazon-corretto wget unzip
              # Install Tomcat
              wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.76/bin/apache-tomcat-9.0.76.zip -O /tmp/tomcat.zip
              unzip /tmp/tomcat.zip -d /opt/
              mv /opt/apache-tomcat-9.0.76 /opt/tomcat
              chmod +x /opt/tomcat/bin/*.sh
              # Download WAR from S3
              aws s3 cp s3://my-bucket-name/myapp.war /opt/tomcat/webapps/myapp.war
              # Start Tomcat
              /opt/tomcat/bin/startup.sh
              EOF

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "web-app-instance"
    }
  }
}

# ==========================================
# 4. Application Load Balancer
# ==========================================
resource "aws_lb" "web_lb" {
  name               = "web-app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web_sg.id]
  subnets            = ["subnet-065d44aa08108a78e", "subnet-02986b069a81a005b"] # Replace with your subnets
}

resource "aws_lb_target_group" "web_tg" {
  name     = "web-app-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = "vpc-00ee66507602824e0"  # Replace with your VPC ID
  health_check {
    path                = "/myapp/"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    matcher             = "200"
  }
}

resource "aws_lb_listener" "web_listener" {
  load_balancer_arn = aws_lb.web_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}

# ==========================================
# 5. Auto Scaling Group
# ==========================================
resource "aws_autoscaling_group" "web_asg" {
  desired_capacity     = 2
  max_size             = 5
  min_size             = 2
  vpc_zone_identifier  = ["subnet-065d44aa08108a78e", "subnet-02986b069a81a005b"] # Replace with your subnets
  launch_template {
    id      = aws_launch_template.web_app.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.web_tg.arn]

  tag {
    key                 = "Name"
    value               = "web-app-instance"
    propagate_at_launch = true
  }
}