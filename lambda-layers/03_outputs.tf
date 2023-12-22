output "dependencies_lambda_layer" {
  value = {
    arn       = module.dependencies_lambda_layer.layer.arn
    layer_arn = module.dependencies_lambda_layer.layer.layer_arn
    version   = module.dependencies_lambda_layer.layer.version
  }
}

output "custom_lambda_layer" {
  value = {
    arn       = module.custom_lambda_layer.layer.arn
    layer_arn = module.custom_lambda_layer.layer.layer_arn
    version   = module.custom_lambda_layer.layer.version
  }
}

output "remote_lambda_layer" {
  value = {
    arn       = module.remote_lambda_layer.layer.arn
    layer_arn = module.remote_lambda_layer.layer.layer_arn
    version   = module.remote_lambda_layer.layer.version
  }
}
