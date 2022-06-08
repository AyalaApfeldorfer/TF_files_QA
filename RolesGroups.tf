provider "aws" {
  profile    = "default"
  region     = "us-east-1"
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
resource "aws_iam_group" "group" {
  name = "test-group"
}
resource "aws_iam_policy" "policy_with_role" {
  name        = "AWSSupportAccess"
  description = "A policy with role"
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

resource "aws_iam_policy_attachment" "attach_role" {
  name       = "test-attachment"
  roles      = [aws_iam_role.role.name]
  policy_arn = aws_iam_policy.policy_with_role.arn
}
resource "aws_iam_policy_attachment" "attach_group" {
  name       = "test-attachment"
  groups     = [aws_iam_group.group.name]
  policy_arn = aws_iam_policy.policy_with_group.arn
}
