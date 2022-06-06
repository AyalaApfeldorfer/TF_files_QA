resource "aws_cloudtrail" "my_aws_cloudtrail_log" {
  name = "my_aws_cloudtrail"
  cloud_watch_logs_group_arn = "${aws_cloudwatch_log_group.example.arn}:*"
}
resource "aws_cloudwatch_log_group" "example" {
  name = "Example"
}
