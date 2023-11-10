# https://registry.terraform.io/providers/hashicorp/aws/5.0.0/docs/resources/cloudwatch_log_group
resource "aws_cloudwatch_log_group" "this" {
  name              = "${var.env}-${var.ecs_cluster_name}"
  retention_in_days = var.retention_in_days

  tags = var.tags
}
