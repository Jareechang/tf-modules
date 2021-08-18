## Networking

A basic terraform module for setting up a VPC on AWS.

- [Caveats](#caveats)
- [Example](#example)
- [Todo](#todo)
- [Requirements](#requirements)
- [Providers](#providers)
- [Inputs](#inputs)
- [Outputs](#outputs)

## Caveats

### Nat Gateway
Only one NAT gateway is created if less than two private subnet is provided (This can be changed).

This module is mainly for staging enivronments right now but for redundancy on production, you definitely want to one NAT gateway per
subnet or AZ.

TODO: To be addressed (wip)


### Port number (80 only) 

The VPC currently only allows for ingress and egress from port 80 right now.


TODO: To be addressed (wip)

## TODO

- allow for multiple nat gateway to be created in module (ie `multiple_nat_gw`) 
- allow for multiple port to be exposed in module (ie `allowed_port` var) 

## Example

```tf
#### Networking (subnets, igw, nat gw, rt etc)
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
| azs | n/a | `list(string)` | <pre>[<br>  "us-east-1a",<br>  "us-east-1b"<br>]</pre> | no |
| env | n/a | `string` | `"dev"` | no |
| project\_id | n/a | `string` | `"web-app"` | no |
| subnet\_private\_cidrblock | n/a | `list(string)` | <pre>[<br>  "10.0.11.0/24",<br>  "10.0.22.0/24"<br>]</pre> | no |
| subnet\_public\_cidrblock | n/a | `list(string)` | <pre>[<br>  "10.0.1.0/24",<br>  "10.0.2.0/24"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| private\_subnets | n/a |
| public\_subnets | n/a |
| vpc\_id | n/a |
