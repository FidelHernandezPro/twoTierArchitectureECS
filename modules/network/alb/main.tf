resource "aws_lb" "alb" {
  name               = "${var.environment}-alb"
  internal           = true
  load_balancer_type = "application"
  subnets            = var.private_subnet_ids              # subnets            = var.public_subnet_ids
  security_groups    = [var.alb_sg_id]
  enable_deletion_protection = false

  tags = {
    Environment = var.environment
    Terraform   = "true"
  }
}

resource "aws_lb_target_group" "alb_target_group" {
  name     = "${var.environment}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = {
    Environment = var.environment
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
}
