# AWS Application Errors rate

A module for converting cloudwatch logs into metrics (event count) based on patterns filters, and alarming on them if they pass a certain threshold (a percentage relative to total request from ALB - 10%, 25%, ... error threshold).

application error logs in cloudwatch and alarming on them based on thresholds.

- [Example](#example)
- [Requirements](#requirements)
- [Providers](#providers)
- [Inputs](#inputs)
- [Outputs](#outputs)

## Example

```tf
module "application_error_alarm" {
    source             = "github.com/Jareechang/tf-modules//cloudwatch/alarms/application-log-errors?ref=v1.0.12"
    evaluation_periods = "2"
    threshold          = "10"
    arn_suffix         = aws_lb.arn_suffix 
    project_id         = "my-test-project" 
    pattern            = "[Error]"
    log_group_name     = "my-log-group"
    metric_name        = "ApplicationErrorCount"
    metric_namespace   = "ECS-node-app-prod"
}
```

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| alarm\_actions | List of resources to trigger during alarm state | `list(string)` | `[]` | no |
| arn\_suffix | The Application Load Balance ARN suffix | `string` | n/a | yes |
| env | The environment for the project | `string` | `"dev"` | no |
| evaluation\_periods | The evaluation periods for this alarm | `string` | `"1"` | no |
| filter\_name | The cloudwatch log filter name | `string` | `"ApplicationErrorCountFilter"` | no |
| insufficient\_data\_actions | List of resources to trigger during insufficient data state | `list(string)` | `[]` | no |
| log\_group\_name | The cloudwatch log group name | `string` | n/a | yes |
| metric\_name | The cloudwatch log filter metric name | `string` | n/a | yes |
| metric\_namespace | The cloudwatch log filter metric namespace | `string` | n/a | yes |
| metric\_period | The period (in seconds) which the statistics is applied | `string` | `"120"` | no |
| ok\_actions | List of resources to trigger during ok state | `list(string)` | `[]` | no |
| pattern | The cloudwatch log filter pattern | `string` | `"[Error]"` | no |
| project\_id | The unique project ID this resource applies to | `string` | n/a | yes |
| threshold | The threshold to check against | `string` | `"10"` | no |

## Outputs

| Name | Description |
|------|-------------|
| name | Name of the alarm |
