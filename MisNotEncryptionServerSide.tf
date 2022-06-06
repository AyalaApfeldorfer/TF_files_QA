resource "aws_cloudwatch_log_group" "example" {
  name = "Example"
}

resource "aws_cloudtrail" "example" {
  cloud_watch_logs_group_arn = "${aws_cloudwatch_log_group.example.arn}:*"
}
