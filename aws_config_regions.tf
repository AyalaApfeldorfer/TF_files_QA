resource "aws_cloudtrail" "cloudtrail1_passed" {
  name                          = "cloudtrail1_passed"
  s3_bucket_name                = aws_s3_bucket.foo.id
  s3_key_prefix                 = "prefix"
  include_global_service_events = false
  cloud_watch_logs_group_arn = aws_cloudwatch_log_group.log_group1.arn
  is_multi_region_trail = true
}

resource "aws_iam_role" "role" {
  name = "test-role"
}

resource "aws_iam_policy_attachment" "test-attach" {
  name       = "test-attachment"
  roles      = [aws_iam_role.role.name]
  policy_arn = aws_iam_policy.policy.arn
}
