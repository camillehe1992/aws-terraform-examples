output "event_rule" {
  value = {
    arn = aws_cloudwatch_event_rule.this.arn
  }
  description = "The CloudWatch Event rule"
}
