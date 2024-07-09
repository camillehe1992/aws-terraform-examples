# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_rest_api
resource "aws_api_gateway_rest_api" "this" {
  name = "${var.environment}-${var.nickname}-${var.rest_api_name}"
  body = templatefile(var.openapi_yaml_file, {
    function_name = "${var.environment}-${var.nickname}-${var.function_name}"
  })

  endpoint_configuration {
    types = ["REGIONAL"]
  }

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Effect": "Allow",
          "Principal": "*",
          "Action": "execute-api:Invoke",
          "Resource": "arn:${data.aws_partition.current.partition}:execute-api:${var.aws_region}:${data.aws_caller_identity.current.account_id}:*"
      }
  ]
}
EOF
  tags   = var.tags
}

resource "aws_api_gateway_deployment" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id

  triggers = {
    redeployment = sha1(aws_api_gateway_rest_api.this.body)
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_cloudwatch_log_group" "api_gw_logs" {
  name              = "/aws/apigateway/${aws_api_gateway_rest_api.this.id}/${var.stage_name}"
  retention_in_days = var.api_gateway_log_retention_days

  tags = var.tags
}

resource "aws_api_gateway_stage" "this" {
  deployment_id = aws_api_gateway_deployment.this.id
  rest_api_id   = aws_api_gateway_rest_api.this.id
  stage_name    = var.stage_name

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gw_logs.arn

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

resource "aws_api_gateway_method_settings" "rest_api" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  stage_name  = aws_api_gateway_stage.this.stage_name
  method_path = "*/*"

  settings {
    metrics_enabled = true
  }
}
