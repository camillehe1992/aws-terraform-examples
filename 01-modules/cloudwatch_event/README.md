# Terraform Module Details

## Variables

| Variable Name       | Type        | Description                                                                  | Default      |
| ------------------- | ----------- | ---------------------------------------------------------------------------- | ------------ |
| environment         | string      | The environment of application                                               | -            |
| nickname            | string      | The nickname of application. Must be lowercase without special chars         | -            |
| tags                | map(string) | The key value pairs we want to apply as tags to the resources in this module | {}           |
| rule_name           | string      | The EventBridge rule name                                                    | -            |
| description         | string      | The description of EventBridge rule                                          | empty string |
| schedule_expression | string      | The schedule expression to trigger the target                                | -            |
| is_enabled          | bool        | If enable the EventBridge rule                                               | true         |
| target_id           | string      | The target id of the EventBridge rule                                        | empty string |
| target_arn          | string      | The target ARN of the EventBridge rule                                       | -            |

## Example Usage

### Basic Usage

```bash
module "event_rule" {
  source = "../01-modules/cloudwatch_event"

  environment = "dev"
  nickname    = "nickname"
  tags = {
    environment = "dev"
    nickname    = "nickname"
  }

  rule_name = "my-event-rule-name"
  description = "The description of my event rule"
  schedule_expression = "rate(1 day)"
  target_id  = "sendToSNS"
  target_arn = ""
}
```

## Outputs

```bash
event_rule = "arn:aws-cn:events:cn-north-1:123456789012:rule/dev-nickname-my-event-rule-name"

```
