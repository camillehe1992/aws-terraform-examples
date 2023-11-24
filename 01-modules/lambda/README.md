Terraform Module Details

## Variables
| Variable Name         | Type          | Description                                                                  | Default      |
| --------------------- | ------------- | ---------------------------------------------------------------------------- | ------------ |
| env                   | string        | The environment of application                                               | -            |
| nickname              | string        | The nickname of application. Must be lowercase without special chars         | -            |
| tags                  | map(string)   | The key value pairs we want to apply as tags to the resources in this module | {}           |
| function_name         | string        | The Lambda function name                                                     | -            |
| description           | string        | The description of Lambda function                                           | empty string |
| role_arn              | string        | The ARN of Lambda function excution role                                     | -            |
| handler               | string        | The handler of Lambda function                                               | -            |
| memory_size           | number        | The memory size (MiB) of Lambda function                                     | 128          |
| timeout               | number        | The timeout (seconds) of Lambda function                                     | 60           |
| runtime               | string        | The runtime of Lambda function                                               | python3.9    |
| source_file           | string        | The file name of Lambda function source code                                 | -            |
| source_dir            | string        | The directory of Lambda function source code. Conflict with source_file      | -            |
| output_path           | string        | The zip file name of Lambda function source code                             | -            |
| layers                | list(string)  | A list of Lambda function associated layers ARN                              | []           |
| environment_variables | map(string)   | A set of environment variables of Lambda function                            | {}           |
| subnet_ids            | list(string)  | A list of Subnet Ids                                                         | []           |
| security_group_ids    | list(string)  | A list of Security group Idsfunction                                         | []           |
| retention_in_days     | number        | The retention (days) of Lambda function Cloudwatch logs group                | 14           |
| lambda_permissions    | map(object()) | A map of lambda permissions                                                  | -            |

## Example Usage

```bash
module "interact_database_func" {
  source = "../01-modules/lambda"

  env      = "dev"
  nickname = "pokemon"
  tags = {
    environment = "dev"
    nickname    = "pokemon"
  }

  function_name = "my-demo-function"
  description   = "The function is used to access RDS database"
  role_arn      = "arn:aws-cn:iam::123456789012:role/lambda-execution-role-name"
  handler       = "src.app.lambda_handler"
  memory_size   = 128
  timeout       = 10
  runtime       = "python3.9"
  source_file   = "./src/app.py"
  output_path   = "app.zip"
  layers = [
    "arn:aws-cn:lambda:cn-north-1:123456789012:layer:aws-lambda-powertools-python:7"
  ]
  environment_variables = {
    LOG_LEVEL = "info"
  }
  subnet_ids            = ["subnet-123", "subnet-456"]
  security_group_ids    = ["sg-789"]
  retention_in_days     = 14
  lambda_permissions = {
    allow-apigateway-invoke = {
      principal  = "apigateway.amazonaws.com",
      source_arn = "arn:aws-cn:execute-api:cn-north-1:123456789012:xxxxxxxx/*/*/*"
    }
  }
}

```

## Outputs
```bash
output "function" {
  value = {
    arn          = aws_lambda_function.this.arn
    cwlogs_group = aws_cloudwatch_log_group.this.arn
  }
}
```

