resource "aws_lb_target_group" "app_lbtg" {
  name     = "${var.app_name}-lbtg-${var.aws_region}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  tags     = local.tags
}

resource "aws_lb" "app_lb" {
  name               = "app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.app_lb_sg.id]
  subnets            = var.vpc_public_subnet_ids
  tags               = local.tags
}

resource "aws_lb_listener" "app_lb_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "forward"
    forward {
      target_group {
        arn = aws_lb_target_group.app_lbtg.arn
      }
      stickiness {
        enabled  = true
        duration = 60
      }
    }
  }
  tags = local.tags
}

resource "aws_autoscaling_attachment" "app_asa" {
  autoscaling_group_name = aws_autoscaling_group.app_asg.id
  lb_target_group_arn    = aws_lb_target_group.app_lbtg.arn
}

resource "aws_autoscaling_group" "app_asg" {
  name                 = "${var.app_name}_asg"
  min_size             = 2
  max_size             = 4
  desired_capacity     = 2
  launch_configuration = aws_launch_configuration.app_launch_config.name
  vpc_zone_identifier  = var.vpc_public_subnet_ids
}