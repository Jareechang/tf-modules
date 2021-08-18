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