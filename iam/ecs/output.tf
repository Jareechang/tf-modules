output "ecs_task_role_arn" {
  value = local.create_ecs_task_role ? aws_iam_role.ecs_task_role[0].arn : ""
}

output "ecs_execution_role_arn" {
    value = aws_iam_role.ecs_execution_role[0].arn
}
