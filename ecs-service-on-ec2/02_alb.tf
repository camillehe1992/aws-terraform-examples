# https://registry.terraform.io/providers/hashicorp/aws/5.0.0/docs/resources/lb
resource "aws_lb" "this" {
  name               = "${var.nickname}-${var.env}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.subnet_ids

  enable_deletion_protection = true

  tags = var.tags
}

resource "aws_lb_target_group" "this" {
  name     = "${var.env}-${var.nickname}-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  tags = var.tags
}

# https://registry.terraform.io/providers/hashicorp/aws/5.0.0/docs/resources/lb_listener
resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "HTTP"
  #   ssl_policy        = "ELBSecurityPolicy-2016-08"
  #   certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}
