// Lambda Function
resource "aws_lambda_function" "this" {
  function_name    = "${var.environment}-${var.nickname}-${var.function_name}"
  filename         = "${path.module}/build/${var.function_name}.zip"
  runtime          = var.runtime
  handler          = "main.lambda_handler"
  source_code_hash = data.archive_file.function_source.output_base64sha256
  role             = aws_iam_role.lambda_exec.arn

  tags = var.tags
}

resource "aws_cloudwatch_log_group" "function_logs" {
  name              = "/aws/lambda/${aws_lambda_function.this.function_name}"
  retention_in_days = var.retention_in_days
}

resource "aws_iam_role" "lambda_exec" {
  name = "${var.environment}-${var.nickname}-${var.function_name}-exec-role"

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
  policy_arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_permission" "api_gw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.this.execution_arn}/*/*"
}
