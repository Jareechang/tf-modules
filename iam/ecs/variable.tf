variable "ecs_execution_other_iam_statements" {
    type = map(object({
        actions   = list(string)
        effect    = string
        resources = list(string)
    }))
    description = "Additional ECS execution iam permission statement to be added"
}

variable "create_ecs_execution_role" {
    type        = bool
    description = "Create an ECS execution role"
}

variable "create_ecs_task_role" {
    type        = bool
    description = "Create an ECS task role"
}
