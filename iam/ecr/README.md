# IAM: ECR

IAM roles & policies relating to managing ECR.

Optionally, an CI/CD IAM user can be generated to manage ECR (and ECS).

- [Example](#example)
- [Requirements](#requirements)
- [Providers](#providers)
- [Inputs](#inputs)
- [Outputs](#outputs)

## Example

```tf
## CI/CD user role for managing pipeline for AWS ECR resources
module "ecr_ecs_ci_user" {
    source            = "github.com/Jareechang/tf-modules//iam/ecr?ref=v1.0.1"
    env               = var.env
    project_id        = var.project_id
    create_ci_user    = true
    ecr_resource_arns = [
        "arn:aws:ecr:${var.aws_region}:${data.aws_caller_identity.current.account_id}:repository/web/${var.project_id}",
        "arn:aws:ecr:${var.aws_region}:${data.aws_caller_identity.current.account_id}:repository/web/${var.project_id}/*"
    ]
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
| create\_ci\_user | Whether or not to create a CI/CD role | `bool` | `false` | no |
| ecr\_resource\_arns | The target ECR arn to add permissions to | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| env | Environment for the project | `string` | `"dev"` | no |
| other\_iam\_statements | Additional iam permission statement to be added | <pre>map(object({<br>        actions   = list(string)<br>        effect    = string<br>        resources = list(string)<br>    }))</pre> | n/a | no |
| project\_id | Unique project ID | `string` | `"web"` | no |

## Outputs

| Name | Description |
|------|-------------|
| aws\_iam\_access\_id | n/a |
| aws\_iam\_access\_key | n/a |
