variable "ecs_execution_policies_extension" {
    type = map(object({
        actions   = list(string)
        effect    = string
        resources = list(string)
    }))
    description = "Additional ECS execution policies to be added"
}

variable "create_ecs_execution_role" {
    type        = bool
    description = "Create an ECS execution role"
}

variable "create_ecs_task_role" {
    type        = bool
    description = "Create an ECS task role"
}
