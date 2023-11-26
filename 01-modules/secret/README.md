# Terraform Module Details

## Variables

| Variable Name | Type        | Description                                                                  | Default |
| ------------- | ----------- | ---------------------------------------------------------------------------- | ------- |
| environment   | string      | The environment of application                                               | -       |
| nickname      | string      | The nickname of application. Must be lowercase without special chars         | -       |
| tags          | map(string) | The key value pairs we want to apply as tags to the resources in this module | {}      |
| secret_specs  | map(object) | A map of secrets specs with description and secret string                    | -       |

### secret_specs

| Variable Name | Type   | Description               | Default |
| ------------- | ------ | ------------------------- | ------- |
| description   | string | The description of secret | -       |
| secret_string | string | The secret value          | -       |

## Example Usage

### Basic Usage

```bash
module "secrets" {
  source = "../01-modules/secret"

 environment     = "dev"
  nickname = "nickname"
  tags = {
    environment = "dev"
    nickname    = "nickname"
  }

  secret_specs = {
    database_password = {
      description   = "A sample secure. e.g password"
      secret_string = var.database_password
    }
  }
}
```

## Outputs

```bash
secrets = {
    database_password = "arn:aws-cn:secretsmanager:cn-north-1:123456789012:secret:/NICKNAME/DEV/CN-NORTH-1/DATABASE_PASSWORD-xxxxxx"
}
```
