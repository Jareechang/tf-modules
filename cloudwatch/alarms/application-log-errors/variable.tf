variable "project_id" {
  type = string
  description = "The unique project ID this resource applies to"
}

variable "env" {
  type = string
  default = "dev"
  description = "The environment for the project"
}

variable "filter_name" {
  type = string
  default = "ApplicationErrorCountFilter"
  description = "The cloudwatch log filter name"
}

variable "pattern" {
  type = string
  default = "[Error]"
  description = "The cloudwatch log filter pattern"
}

variable "log_group_name" {
  type = string
  description = "The cloudwatch log group name"
}

variable "metric_name" {
  type = string
  description = "The cloudwatch log filter metric name"
}

variable "metric_namespace" {
  type = string
  description = "The cloudwatch log filter metric namespace"
}

variable "evaluation_periods" {
  type    = string
  default = "1"
  description = "The evaluation periods for this alarm"
}

variable "threshold" {
  type    = string
  default = "10"
  description = "The threshold to check against"
}

variable "metric_period" {
  type    = string
  default = "120"
  description = "The period (in seconds) which the statistics is applied"
}

variable "arn_suffix" {
  type    = string
  description = "The Application Load Balance ARN suffix"
}

variable "alarm_actions" {
  type    = list(string)
  default = []
  description = "List of resources to trigger during alarm state"
}

variable "ok_actions" {
  type    = list(string)
  default = []
  description = "List of resources to trigger during ok state"
}

variable "insufficient_data_actions" {
  type    = list(string)
  default = []
  description = "List of resources to trigger during insufficient data state"
}
