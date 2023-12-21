# Module Overview

The detailed information about the module.

## Providers

| Name | Version |
| ---- | ------- |
| aws  | n/a     |

The module automatically inherits default provider configurations from its parent.

## Resources

| Name                                                                                                                                                    | Type        |
| ------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_secretsmanager_secret.secrets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret)                  | resource    |
| [aws_secretsmanager_secret_version.versions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource    |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region)                                             | data source |

## Inputs

| Name          | Description                                                                            | Type                                                               | Default | Required |
| ------------- | -------------------------------------------------------------------------------------- | ------------------------------------------------------------------ | ------- | :------: |
| environment   | The environment of application                                                         | `string`                                                           | n/a     |   yes    |
| nickname      | The nickname of application                                                            | `string`                                                           | n/a     |   yes    |
| secret\_specs | A map of secrets specs with description and secret string                              | ```map(object({ description = string secret_string = string }))``` | n/a     |   yes    |
| tags          | The key value pairs we want to apply as tags to the resources contained in this module | `map(string)`                                                      | n/a     |   yes    |

## Outputs

| Name    | Description |
| ------- | ----------- |
| secrets | n/a         |
