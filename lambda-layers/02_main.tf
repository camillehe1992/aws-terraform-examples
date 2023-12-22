module "dependencies_lambda_layer" {
  source = "../01-modules/lambda_layer"

  environment = var.environment
  nickname    = var.nickname
  tags        = var.tags

  layer_name  = "dependencies"
  pip_install = true
  from_local  = true
}

module "custom_lambda_layer" {
  source = "../01-modules/lambda_layer"

  environment = var.environment
  nickname    = var.nickname
  tags        = var.tags

  layer_name  = "custom"
  source_path = "core"
  is_custom   = true
  from_local  = true
}

module "remote_lambda_layer" {
  source = "../01-modules/lambda_layer"

  environment = var.environment
  nickname    = var.nickname
  tags        = var.tags

  layer_name  = "remote"
  pip_install = true
  from_s3     = true
  s3_bucket   = var.s3_bucket
}
