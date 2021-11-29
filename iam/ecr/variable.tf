variable "project_id" {
    type = string
    default = "web"
    description = "Unique project ID"
}

variable "env" {
    type = string
    default = "dev"
    description = "Environment for the project"
}

variable "create_ci_user" {
    type = bool
    default = false
    description = "Whether or not to create a CI/CD role"
}

variable "ecr_resource_arns" {
    type = list(string)
    default = [""]
    description = "The target ECR arn to add permissions to"
}

variable "other_iam_statements" {
    type = map(object({
        actions   = list(string)
        effect    = string
        resources = list(string)
    }))
    default = null
    description = "Additional iam permission statement to be added"
}
