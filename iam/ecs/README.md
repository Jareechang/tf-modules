# IAM: ECR

IAM roles & policies relating to ECS task and execution roles.

Both are optionally created with a boolean parameter provided to the module. 

- [Example](#example)
- [Todo](#todo)
- [Requirements](#requirements)
- [Providers](#providers)
- [Inputs](#inputs)
- [Outputs](#outputs)

## Example

```tf
## ECS Execution and Task roles
module "ecs_roles" {
    source                    = "github.com/Jareechang/tf-modules//iam/ecs?ref=v1.0.7"
    create_ecs_execution_role = true
    create_ecs_task_role      = true

    # Extend baseline policy statements
     ecs_execution_other_iam_statements = {
        ssm = {
            actions = [
                "ssm:GetParameter",
                "ssm:GetParameters",
                "ssm:GetParametersByPath"
            ]
            effect = "Allow"
            resources = [
                "arn:aws:ssm:${var.aws_region}:${data.aws_caller_identity.current.account_id}:parameter/web/${var.project_id}/*"
            ]
        }
        kms = {
            actions = [
                "kms:Decrypt"
            ]
            effect = "Allow"
            resources = [
                aws_kms_key.default.arn
            ]
        }
    }
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
| create\_ecs\_execution\_role | Create an ECS execution role | `bool` | n/a | yes |
| create\_ecs\_task\_role | Create an ECS task role | `bool` | n/a | yes |
| ecs\_execution\_iam\_statements | IAM permission statement(s) to be added to the ECS Execution role | <pre>map(object({<br>    actions   = list(string)<br>    effect    = string<br>    resources = list(string)<br>  }))</pre> | `null` | no |
| ecs\_task\_iam\_statements | IAM permission statement(s) to be added to the ECS Task role | <pre>map(object({<br>    actions   = list(string)<br>    effect    = string<br>    resources = list(string)<br>  }))</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| ecs\_execution\_role\_arn | n/a |
| ecs\_task\_role\_arn | n/a |
