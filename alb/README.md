## Application LB & Target Group

A basic terraform module for setting up Application load balancers and target groups. 

By default, http listener are created to forward to target group but https can be supported via `enable_https` (see below for more options).

- [Example](#example)
- [Todo](#todo)
- [Requirements](#requirements)
- [Providers](#providers)
- [Inputs](#inputs)
- [Outputs](#outputs)

## Example

```tf
#### VPC 
module "networking" {
    source = "github.com/Jareechang/tf-modules//networking?ref=v1.0.0"
    env = var.env
    project_id = var.project_id
    subnet_public_cidrblock = [
        "10.0.1.0/24",
        "10.0.2.0/24"
    ]
    subnet_private_cidrblock = [
        "10.0.11.0/24",
        "10.0.22.0/24"
    ]
    azs = ["us-east-1a", "us-east-1b"]
}

#### Target group 
module "ecs_tg" {
    source              = "github.com/Jareechang/tf-modules//alb?ref=v1.0.2"
    create_target_group = true
    port                = 80
    protocol            = "HTTP"
    target_type         = "ip"
    vpc_id              = module.networking.vpc_id
}

#### ALB 
module "alb" {
    source              = "github.com/Jareechang/tf-modules//alb?ref=v1.0.2"
    create_alb         = true
    enable_https       = false
    internal           = false
    load_balancer_type = "application"
    security_groups    = [aws_security_group.alb_ecs_sg.id]
    subnets            = module.networking.public_subnets[*].id
    target_group       = module.ecs_tg.tg.arn
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
| create\_alb | Whether or not to create an ALB | `bool` | `false` | no |
| create\_target\_group | Whether or not to create an LB target group | `bool` | `false` | no |
| enable\_https | n/a | `bool` | `false` | no |
| env | Environment for the project | `string` | `"dev"` | no |
| internal | n/a | `bool` | `false` | no |
| load\_balancer\_type | n/a | `string` | `"application"` | no |
| port | Port for the target group | `number` | `80` | no |
| project\_id | Unique project ID | `string` | `"web"` | no |
| protocol | n/a | `string` | `"HTTP"` | no |
| security\_groups | n/a | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| subnets | n/a | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| target\_group | n/a | `string` | `"ip"` | no |
| target\_type | n/a | `string` | `"ip"` | no |
| vpc\_id | n/a | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| http\_listener | The http listener info |
| https\_listener | The https listner info |
| lb | The load balancer info |
| tg | The target group info |
