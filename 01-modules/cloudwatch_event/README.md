# Module Overview

The detailed information about the module.

## Providers

| Name | Version |
| ---- | ------- |
| aws  | n/a     |

The module automatically inherits default provider configurations from its parent.

## Resources

| Name                                                                                                                                    | Type     |
| --------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [aws_cloudwatch_event_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule)     | resource |
| [aws_cloudwatch_event_target.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |

## Inputs

| Name                 | Description                                                                            | Type          | Default | Required |
| -------------------- | -------------------------------------------------------------------------------------- | ------------- | ------- | :------: |
| description          | The description of EventBridge rule                                                    | `string`      | `""`    |    no    |
| environment          | The environment of application                                                         | `string`      | n/a     |   yes    |
| is\_enabled          | If enable the EventBridge rule                                                         | `bool`        | `true`  |    no    |
| nickname             | The nickname of application. Must be lowercase without special chars                   | `string`      | n/a     |   yes    |
| rule\_name           | The EventBridge rule name                                                              | `string`      | n/a     |   yes    |
| schedule\_expression | The schedule expression to trigger the target                                          | `string`      | n/a     |   yes    |
| tags                 | The key value pairs we want to apply as tags to the resources contained in this module | `map(string)` | n/a     |   yes    |
| target\_arn          | The target ARN of the EventBridge rule                                                 | `string`      | n/a     |   yes    |
| target\_id           | The target id of the EventBridge rule                                                  | `string`      | `""`    |    no    |

## Outputs

| Name        | Description               |
| ----------- | ------------------------- |
| event\_rule | The CloudWatch Event rule |
