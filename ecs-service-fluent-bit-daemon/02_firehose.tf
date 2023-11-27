# https://registry.terraform.io/providers/hashicorp/aws/5.0.0/docs/resources/kinesis_firehose_delivery_stream
resource "aws_kinesis_firehose_delivery_stream" "this" {
  name        = var.firehose_delivery_stream_name
  destination = "extended_s3"

  extended_s3_configuration {
    role_arn   = module.firehose_delivery_role.iam_role.arn
    bucket_arn = "arn:${data.aws_partition.current.partition}:s3:::${var.firehose_bucket_name}"
  }

  tags = var.tags
}
