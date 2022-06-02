provider "aws" {
  profile    = "default"
  region     = "us-east-1"
}


resource "aws_cloudtrail" "cloudtrail_single_region_failed" {
  name                          = "cloudtrail_single_region_failed"
  s3_bucket_name                = aws_s3_bucket.foo.id
  s3_key_prefix                 = "prefix"
  include_global_service_events = false
  cloud_watch_logs_group_arn = aws_cloudwatch_log_group.log_group1.arn
  is_multi_region_trail = flase
}


resource "aws_cloudtrail" "cloudtrail_no_log_group_failed" {
  name                          = "cloudtrail_no_log_group_failed"
  s3_bucket_name                = aws_s3_bucket.foo.id
  s3_key_prefix                 = "prefix"
  include_global_service_events = false
  is_multi_region_trail = true
}


resource "aws_cloudtrail" "cloudtrail1_passed" {
  name                          = "cloudtrail1_passed"
  s3_bucket_name                = aws_s3_bucket.foo.id
  s3_key_prefix                 = "prefix"
  include_global_service_events = false
  cloud_watch_logs_group_arn = aws_cloudwatch_log_group.log_group1.arn
  is_multi_region_trail = true
}

resource "aws_cloudtrail" "cloudtrail_with_log_group_no_metric_failed" {
  name                          = "cloudtrail_with_log_group_no_metric_failed"
  s3_bucket_name                = aws_s3_bucket.foo.id
  s3_key_prefix                 = "prefix"
  include_global_service_events = false
  cloud_watch_logs_group_arn = aws_cloudwatch_log_group.log_group_no_metric.arn
  is_multi_region_trail = true
}

resource "aws_cloudtrail" "cloudtrail_with_log_group_bad_metric_failed" {
  name                          = "cloudtrail_with_log_group_bad_metric_failed"
  s3_bucket_name                = aws_s3_bucket.foo.id
  s3_key_prefix                 = "prefix"
  include_global_service_events = false
  cloud_watch_logs_group_arn = aws_cloudwatch_log_group.log_group_bad_metric.arn
  is_multi_region_trail = true
}

resource "aws_cloudtrail" "cloudtrail_no_metric_alarm_failed" {
  name                          = "cloudtrail_no_metric_alarm_failed"
  s3_bucket_name                = aws_s3_bucket.foo.id
  s3_key_prefix                 = "prefix"
  include_global_service_events = false
  cloud_watch_logs_group_arn = aws_cloudwatch_log_group.log_group_no_metric_alarm.arn
  is_multi_region_trail = true
}

resource "aws_cloudtrail" "cloudtrail_metric_alarm_not_enabled_failed" {
  name                          = "cloudtrail_metric_alarm_not_enabled_failed"
  s3_bucket_name                = aws_s3_bucket.foo.id
  s3_key_prefix                 = "prefix"
  include_global_service_events = false
  cloud_watch_logs_group_arn = aws_cloudwatch_log_group.log_group_metric_alarm_not_enabled.arn
  is_multi_region_trail = true
}

resource "aws_cloudtrail" "cloudtrail_metric_alarm_action_not_sns_failed" {
  name                          = "cloudtrail_metric_alarm_action_not_sns_failed"
  s3_bucket_name                = aws_s3_bucket.foo.id
  s3_key_prefix                 = "prefix"
  include_global_service_events = false
  cloud_watch_logs_group_arn = aws_cloudwatch_log_group.log_group_metric_alarm_action_not_sns.arn
  is_multi_region_trail = true
}

resource "aws_cloudwatch_log_group" "log_group1" {
  name = "log_group1"

  tags = {
    Environment = "production"
    Application = "serviceA"
  }
}

resource "aws_cloudwatch_log_group" "log_group_no_metric" {
  name = "log_group_no_metric"

  tags = {
    Environment = "production"
    Application = "serviceA"
  }
}

resource "aws_cloudwatch_log_group" "log_group_bad_metric" {
  name = "log_group_bad_metric"

  tags = {
    Environment = "production"
    Application = "serviceA"
  }
}

resource "aws_cloudwatch_log_group" "log_group_no_metric_alarm" {
  name = "log_group_no_metric_alarm"

  tags = {
    Environment = "production"
    Application = "serviceA"
  }
}

resource "aws_cloudwatch_log_group" "log_group_metric_alarm_not_enabled" {
  name = "log_group_metric_alarm_not_enabled"

  tags = {
    Environment = "production"
    Application = "serviceA"
  }
}

resource "aws_cloudwatch_log_group" "log_group_metric_alarm_action_not_sns" {
  name = "log_group_metric_alarm_action_not_sns"

  tags = {
    Environment = "production"
    Application = "serviceA"
  }
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

resource "aws_cloudwatch_log_metric_filter" "bad_metric_filter" {
  name           = "bad_metric_filter"
  pattern        = "{ ($.eventName = CreateTrail) || ($.eventName = UpdateTrail) || ($.eventName = DeleteTrail) || ($.eventName = StartLogging) || ($.eventName = StopLogging) } not equals"
  log_group_name = aws_cloudwatch_log_group.log_group_bad_metric

  metric_transformation {
    name      = "EventCount"
    namespace = "YourNamespace"
    value     = "1"
  }
}

resource "aws_cloudwatch_log_metric_filter" "no_metric_alarm" {
  name           = "no_metric_alarm"
  pattern        = "{ ($.eventName = CreateTrail) || ($.eventName = UpdateTrail) || ($.eventName = DeleteTrail) || ($.eventName = StartLogging) || ($.eventName = StopLogging) }"
  log_group_name = aws_cloudwatch_log_group.log_group_no_metric_alarm

  metric_transformation {
    name      = "EventCount"
    namespace = "YourNamespace"
    value     = "1"
  }
}

resource "aws_cloudwatch_log_metric_filter" "metric_alarm_not_enabled" {
  name           = "MyAppAccessCount"
  pattern        = "{ ($.eventName = CreateTrail) || ($.eventName = UpdateTrail) || ($.eventName = DeleteTrail) || ($.eventName = StartLogging) || ($.eventName = StopLogging) }"
  log_group_name = aws_cloudwatch_log_group.log_group_metric_alarm_not_enabled

  metric_transformation {
    name      = "EventCount"
    namespace = "YourNamespace"
    value     = "1"
  }
}

resource "aws_cloudwatch_log_metric_filter" "metric_alarm_action_not_sns" {
  name           = "metric_alarm_action_not_sns"
  pattern        = "{ ($.eventName = CreateTrail) || ($.eventName = UpdateTrail) || ($.eventName = DeleteTrail) || ($.eventName = StartLogging) || ($.eventName = StopLogging) }"
  log_group_name = aws_cloudwatch_log_group.log_group_metric_alarm_action_not_sns

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


resource "aws_cloudwatch_metric_alarm" "alarm_actions_not_enabled" {
  metric_name = aws_cloudwatch_log_metric_filter.metric_alarm_not_enabled.name
  actions_enabled = false
  alarm_actions       = [aws_sns_topic.sns.arn]
}

resource "aws_cloudwatch_metric_alarm" "alarm_actions_not_sns" {
  metric_name = aws_cloudwatch_log_metric_filter.metric_alarm_action_not_sns.name
  actions_enabled = true
  alarm_actions       = [aws_autoscaling_policy.bat.arn]
}


