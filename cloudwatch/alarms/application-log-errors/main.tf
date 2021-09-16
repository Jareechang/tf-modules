resource "aws_cloudwatch_log_metric_filter" "this" {
  name           = var.filter_name
  pattern        = var.pattern
  log_group_name = var.log_group_name
  metric_transformation {
    name          = var.metric_name
    namespace     = var.metric_namespace
    value         = "1"
    default_value = "0"
    unit          = "Count"
  }
}

resource "aws_cloudwatch_metric_alarm" "error_log_alarm" {
  alarm_name                = "${var.project_id}-${var.env}-application-error-rate"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = var.evaluation_periods
  threshold                 = var.threshold
  alarm_description         = "Application error rate has exceeded ${var.threshold}%"
  ok_actions                = var.ok_actions
  alarm_actions             = var.alarm_actions
  insufficient_data_actions = var.insufficient_data_actions

  metric_query {
    id          = "e1"
    expression  = "m2/m1*100"
    label       = "Application Error Rate (>= ${var.threshold})"
    return_data = "true"
  }

  metric_query {
    id = "m1"
    metric {
      metric_name = "RequestCount"
      namespace   = "AWS/ApplicationELB"
      period      = var.metric_period
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
      metric_name = var.metric_name
      namespace   = var.metric_namespace
      period      = var.metric_period
      stat        = "Sum"
    }
  }
}
