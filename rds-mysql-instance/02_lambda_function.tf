module "lambda_execution_role" {
  source = "../01-modules/iam"

  tags = var.tags

  name_prefix      = "${var.environment}-${var.nickname}-"
  role_name        = "LambdaExecutionRole"
  role_description = "The lambda execution role to access RDS"
  aws_managed_policy_arns = [
    "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
    "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AWSLambdaENIManagementAccess"
  ]
  customized_policies = {
    allow-secrets-policy = data.aws_iam_policy_document.lambda_role_inline_policy.json
  }
}

resource "null_resource" "lambda_dependencies" {
  provisioner "local-exec" {
    command = "cd ${path.module}/src && npm install"
  }

  triggers = {
    index   = sha256(file("${path.module}/src/index.js"))
    package = sha256(file("${path.module}/src/package.json"))
    lock    = sha256(file("${path.module}/src/package-lock.json"))
    node    = sha256(join("", fileset(path.module, "src/**/*.js")))
  }
}

module "interact_database_func" {
  depends_on = [null_resource.lambda_dependencies]
  source     = "../01-modules/lambda"

  environment = var.environment
  nickname    = var.nickname
  tags        = var.tags

  function_name = "rds-initializer"
  description   = "The function is used to initialize RDS database"
  role_arn      = module.lambda_execution_role.iam_role.arn
  handler       = "index.handler"
  runtime       = "nodejs18.x"
  source_dir    = "./src"
  output_path   = "rds-initializer.zip"
  environment_variables = {
    SECRET_ARN = aws_db_instance.this.master_user_secret[0].secret_arn,
    DB_HOST    = aws_db_instance.this.address
  }
  subnet_ids         = var.subnet_ids
  security_group_ids = var.vpc_security_group_ids
  lambda_permissions = {}
}
