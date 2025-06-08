resource "aws_eip" "nlb_eip" {
  domain = "vpc"
  tags = {
    Name = "${var.environment}-nlb-eip"
  }
}

resource "aws_lb" "nlb" {
  name               = "${var.environment}-nlb"
  internal           = false
  load_balancer_type = "network"
  subnets            = var.public_subnet_ids

  enable_deletion_protection = false

  tags = {
    Environment = var.environment
    Terraform   = "true"
  }
}

resource "aws_lb_target_group" "nlb_tg" {
  name        = "${var.environment}-nlb-tg"
  port        = 80
  protocol    = "TCP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    protocol = "TCP"
  }

  tags = {
    Environment = var.environment
  }
}

resource "aws_lb_listener" "tcp" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = 80
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb_tg.arn
  }
}
