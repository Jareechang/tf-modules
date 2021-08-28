# AWS Applicaiton load balancer - Http 5xx alarm

A module for handling ALB http error rate (http 5xx target / request count).

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
| evaluation\_periods | The evaluation periods for this alarm | `string` | `"1"` | no |
| insufficient\_data\_actions | List of resources to trigger during insufficient data state | `list(string)` | `[]` | no |
| ok\_actions | List of resources to trigger during ok state | `list(string)` | `[]` | no |
| project\_id | The unique project ID this resource applies to | `string` | `"web-dev"` | no |
| threshold | The threshold to check against | `string` | `"10"` | no |

## Outputs

No output.
