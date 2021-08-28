resource "aws_cloudwatch_metric_alarm" "this" {
  alarm_name                = "${var.project_id}-http-target-error-rate"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = var.evaluation_periods
  threshold                 = var.threshold
  alarm_description         = "Request error rate has exceeded ${var.threshold}%"
  insufficient_data_actions = var.insufficient_data_actions
  alarm_actions             = var.alarm_actions
  ok_actions                = var.ok_actions

  metric_query {
    id          = "e1"
    expression  = "m2/m1*100"
    label       = "Error Rate"
    return_data = "true"
  }

  metric_query {
    id = "m1"
    metric {
      metric_name = "RequestCount"
      namespace   = "AWS/ApplicationELB"
      period      = "120"
      stat        = "Sum"
      unit        = "Count"

      dimensions = {
        LoadBalancer = var.arn_suffix
      }
    }
  }

  metric_query {
    id = "m2"
    metric {
      metric_name = "HTTPCode_Target_5XX_Count"
      namespace   = "AWS/ApplicationELB"
      period      = "120"
      stat        = "Sum"
      unit        = "Count"

      dimensions = {
        LoadBalancer = var.arn_suffix
      }
    }
  }
}
