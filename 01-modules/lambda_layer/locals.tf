locals {
  resource_prefix = "${var.environment}-${var.nickname}-"
  s3_key_prefix   = "${var.nickname}/${var.environment}/${data.aws_region.current.name}"
  archive_path    = "${path.cwd}/build/${var.layer_name}"
  platform        = var.architecture == "arm64" ? "manylinux2014_aarch64" : "manylinux2014_x86_64"
  runtime         = var.runtimes[0]
}
