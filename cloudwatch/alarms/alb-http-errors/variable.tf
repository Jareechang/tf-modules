variable "project_id" {
  type = string
  description = "The unique project ID this resource applies to"
}

variable "arn_suffix" {
  type = string
  description = "The Loadbalancer Arn Suffix for cloudwatch metrics"
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
