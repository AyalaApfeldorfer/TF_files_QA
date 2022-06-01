resource "aws_cloudtrail" "cloudtrail1_passed" {
  name                          = "cloudtrail1_passed"
  s3_bucket_name                = aws_s3_bucket.foo.id
  s3_key_prefix                 = "prefix"
  include_global_service_events = false
  cloud_watch_logs_group_arn = aws_cloudwatch_log_group.log_group1.arn
  is_multi_region_trail = true
}

resource "aws_iam_user" "user" {
  name = "test-user"
}

resource "aws_iam_role" "role" {
  name = "test-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "policy" {
  name        = "test-policy"
  description = "A test policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "test-attach" {
  name       = "test-attachment"
  users      = [aws_iam_user.user.name]
  roles      = [aws_iam_role.role.name]
  policy_arn = aws_iam_policy.policy.arn
}
