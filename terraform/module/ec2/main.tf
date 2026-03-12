resource "aws_launch_template" "java_app" {
  name_prefix   = "java-app-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  security_group_names = [var.sg_name]
  
  user_data = file(var.user_data_file)
}

resource "aws_autoscaling_group" "java_app_asg" {
  launch_template {
    id      = aws_launch_template.java_app.id
    version = "$Latest"
  }
  vpc_zone_identifier = [var.private_subnet_id]
  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.desired_capacity
  target_group_arns   = [var.target_group_arn]
  health_check_type   = "EC2"
  health_check_grace_period = 300
}