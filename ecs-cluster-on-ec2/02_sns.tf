# https://registry.terraform.io/providers/hashicorp/aws/5.0.0/docs/resources/sns_topic
resource "aws_sns_topic" "this" {
  name = "${var.environment}-${var.nickname}-ecs-container-draining"
}

# https://registry.terraform.io/providers/hashicorp/aws/5.0.0/docs/resources/sns_topic_subscription
resource "aws_sns_topic_subscription" "trigger_lambda" {
  topic_arn = aws_sns_topic.this.arn
  protocol  = "lambda"
  endpoint  = module.ecs_container_draining_function.function.arn
}
