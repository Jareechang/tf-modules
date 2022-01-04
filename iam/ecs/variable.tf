variable "ecs_execution_iam_statements" {
  type = map(object({
    actions   = list(string)
    effect    = string
    resources = list(string)
  }))
  default = null
  description = "IAM permission statement(s) to be added to the ECS Execution role"
}

variable "ecs_task_iam_statements" {
  type = map(object({
    actions   = list(string)
    effect    = string
    resources = list(string)
  }))
  default = null
  description = "IAM permission statement(s) to be added to the ECS Task role"
}

variable "create_ecs_execution_role" {
  type        = bool
  description = "Create an ECS execution role"
}

variable "create_ecs_task_role" {
  type        = bool
  description = "Create an ECS task role"
}
