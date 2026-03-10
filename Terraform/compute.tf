resource "aws_launch_template" "app" {
    name_prefix = "app-template"
    image_id = "ami-0aaa636894689fa47"
    instance_type = "t3.micro"
  
}

resource "aws_autoscaling_group" "app_asg" {

  desired_capacity = 2
  max_size         = 4
  min_size         = 2

  vpc_zone_identifier = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id
  ]

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.app_tg.arn]
}