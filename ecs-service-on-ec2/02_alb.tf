resource "aws_lb_target_group" "this" {
  name        = "${var.env}-${var.nickname}-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    path = "/health"
  }

  tags = var.tags
}

# https://registry.terraform.io/providers/hashicorp/aws/5.0.0/docs/resources/lb
resource "aws_lb" "this" {
  name               = "${var.nickname}-${var.env}-alb"
  internal           = false
  load_balancer_type = "application"
  idle_timeout       = 60
  ip_address_type    = "ipv4"
  security_groups    = var.security_groups
  subnets            = var.public_subnet_ids

  tags = var.tags
}

# https://registry.terraform.io/providers/hashicorp/aws/5.0.0/docs/resources/lb_listener
resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}
