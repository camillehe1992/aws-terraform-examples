data "aws_partition" "current" {}

data "archive_file" "function_source" {
  type = "zip"

  source_dir  = "${path.module}/src"
  output_path = "${path.module}/${var.function_name}.zip"
}

// Lambda Function
resource "aws_lambda_function" "this" {
  function_name    = "${var.env}-${var.nickname}-${var.function_name}"
  runtime          = var.runtime
  handler          = "main.lambda_handler"
  source_code_hash = data.archive_file.function_source.output_base64sha256
  role             = aws_iam_role.lambda_exec.arn

  tags = var.tags
}

resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/lambda/${aws_lambda_function.this.function_name}"
  retention_in_days = 7
}

resource "aws_iam_role" "lambda_exec" {
  name = "${aws_lambda_function.this.function_name}-exec-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:${data.aws_partition.current.value}:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# API Gateway

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_rest_api

resource "aws_apigatewayv2_api" "this" {
  name          = "${aws_lambda_function.this.function_name}-gateway"
  protocol_type = "HTTP"

  tags = var.tags
}

resource "aws_apigatewayv2_stage" "this" {
  api_id = aws_apigatewayv2_api.this.id

  name        = "v1"
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gw.arn

    format = jsonencode({
      requestId               = "$context.requestId"
      sourceIp                = "$context.identity.sourceIp"
      requestTime             = "$context.requestTime"
      protocol                = "$context.protocol"
      httpMethod              = "$context.httpMethod"
      resourcePath            = "$context.resourcePath"
      routeKey                = "$context.routeKey"
      status                  = "$context.status"
      responseLength          = "$context.responseLength"
      integrationErrorMessage = "$context.integrationErrorMessage"
      }
    )
  }
}

resource "aws_apigatewayv2_integration" "hello_world" {
  api_id = aws_apigatewayv2_api.this.id

  integration_uri    = aws_lambda_function.this.invoke_arn
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "this" {
  api_id = aws_apigatewayv2_api.this.id

  route_key = "GET /hello"
  target    = "integrations/${aws_apigatewayv2_integration.this.id}"
}

resource "aws_cloudwatch_log_group" "api_gw" {
  name              = "/aws/api_gw/${aws_apigatewayv2_api.this.name}"
  retention_in_days = 7
}

resource "aws_lambda_permission" "api_gw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.lambda.execution_arn}/*/*"
}
