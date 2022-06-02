resource "aws_cloudtrail" "cloudtrail_single_region_failed" {
  name                          = "cloudtrail_single_region_failed"
  s3_bucket_name                = aws_s3_bucket.foo.id
  s3_key_prefix                 = "prefix"
  include_global_service_events = false
  cloud_watch_logs_group_arn = aws_cloudwatch_log_group.log_group1.arn
  is_multi_region_trail = false
}
resource "aws_cloudwatch_log_group" "log_group2" {
  name = "log_group2"

  tags = {
    Environment = "production"
    Application = "serviceA"
  }
}
