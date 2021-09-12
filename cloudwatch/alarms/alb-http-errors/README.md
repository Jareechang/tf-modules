# AWS Applicaiton load balancer - Http 5xx alarm

A module for handling ALB http error rate (http 5xx target / request count).

- [Example](#example)
- [Requirements](#requirements)
- [Providers](#providers)
- [Inputs](#inputs)
- [Outputs](#outputs)

## Example

```tf
module "http_error_alarm" {
    source             = "github.com/Jareechang/tf-modules//cloudwatch/alarms/alb-http-errors?ref=v1.0.5"
    evaluation_preiods = "4"
    threshold          = "25"
    arn_suffix         = aws_lb.arn_suffix 
    project_id         = "my-test-project" 
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
| arn\_suffix | The Loadbalancer Arn Suffix for cloudwatch metrics | `string` | n/a | yes |
| evaluation\_periods | The evaluation periods for this alarm | `string` | `"1"` | no |
| insufficient\_data\_actions | List of resources to trigger during insufficient data state | `list(string)` | `[]` | no |
| ok\_actions | List of resources to trigger during ok state | `list(string)` | `[]` | no |
| project\_id | The unique project ID this resource applies to | `string` | n/a | yes |
| threshold | The threshold to check against | `string` | `"10"` | no |

## Outputs

| Name | Description |
|------|-------------|
| name | Name of the alarm |
