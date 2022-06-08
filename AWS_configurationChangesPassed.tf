resource "aws_cloudtrail" "cloudtrail1_passed" {
  name                          = "cloudtrail1_passed"
  s3_bucket_name                = aws_s3_bucket.foo.id
  s3_key_prefix                 = "prefix"
  include_global_service_events = false
  cloud_watch_logs_group_arn = aws_cloudwatch_log_group.log_group1.arn
  is_multi_region_trail = true
}
resource "aws_cloudwatch_log_group" "log_group1" {
  name = "log_group1"
  tags = {
    Environment = "production"
    Application = "serviceA"
  }
}
resource "aws_cloudwatch_log_metric_filter" "metric_filter1" {
  name           = "metric_filter1"
  pattern        = "{ ($.eventName = CreateNetworkAcl) || ($.eventName = CreateNetworkAclEntry) || ($.eventName = DeleteNetworkAcl) || ($.eventName = DeleteNetworkAclEntry) || ($.eventName = ReplaceNetworkAclEntry) || ($.eventName = ReplaceNetworkAclAssociation) }"
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
