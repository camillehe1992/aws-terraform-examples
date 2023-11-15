# https://registry.terraform.io/providers/hashicorp/aws/5.0.0/docs/resources/cloudwatch_event_rule
resource "aws_cloudwatch_event_rule" "this" {
  name                = "${var.env}-${var.nickname}-${var.rule_name}"
  description         = var.description
  schedule_expression = var.schedule_expression
  is_enabled          = var.is_enabled

  tags = var.tags

}

# https://registry.terraform.io/providers/hashicorp/aws/5.0.0/docs/resources/cloudwatch_event_target
resource "aws_cloudwatch_event_target" "this" {
  rule      = aws_cloudwatch_event_rule.this.name
  target_id = var.target_id
  arn       = var.target_arn
}
