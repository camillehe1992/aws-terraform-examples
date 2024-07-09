# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition
# https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file
data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

data "archive_file" "function_source" {
  type = "zip"

  source_dir  = "${path.module}/src"
  output_path = "${path.module}/build/${var.function_name}.zip"
}

data "local_file" "openapi_spec" {
  filename = var.openapi_yaml_file
}
