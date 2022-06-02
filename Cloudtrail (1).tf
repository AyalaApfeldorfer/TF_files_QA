provider "aws" {
  profile    = "default"
  region     = "us-east-1"
}

resource "aws_cloudtrail" "cloudtrail_single_region_failed" {
  name                          = "cloudtrail_single_region_failed"
  include_global_service_events = false
  cloud_watch_logs_group_arn = aws_cloudwatch_log_group.log_group1.arn
  is_multi_region_trail = flase
}

resource "aws_cloudwatch_log_group" "log_group1" {
  name = "log_group1"
}

resource "aws_cloudwatch_log_metric_filter" "metric_filter1" {
  name           = "metric_filter1"
  pattern        = "{ ($.eventName = CreateTrail) || ($.eventName = UpdateTrail) || ($.eventName = DeleteTrail) || ($.eventName = StartLogging) || ($.eventName = StopLogging) }"
  log_group_name = aws_cloudwatch_log_group.log_group1

  metric_transformation {
    name      = "EventCount"
    namespace = "YourNamespace"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "alarm_sns_actions_enabled" {
  metric_name = aws_cloudwatch_log_metric_filter.metric_filter1.name
  actions_enabled = true
  alarm_actions       = [aws_autoscaling_policy.bat.arn,aws_sns_topic.sns.arn]
}
