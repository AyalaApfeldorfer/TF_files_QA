provider "aws" {
  profile    = "default"
  region     = "us-east-1"
}
resource "aws_iam_user" "user_with_internal_policy" {
  name = "user_with_internal_policy"
  permissions_boundary = aws_iam_policy.internal_policy_with_user.arn
}
resource "aws_iam_user" "user_with_managed_policy" {
  name = "user_with_managed_policy"
}
resource "aws_iam_role" "role_with_managed_policy" {
  name = "role_with_managed_policy"
}
resource "aws_iam_policy" "policy_no_user" {
  name        = "policy_no_user"
  description = "Policy not attached to users"
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
resource "aws_iam_policy" "internal_policy_with_user" {
  name        = "internal_policy_with_user"
  description = "An internal policy attached to user"
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
resource "aws_iam_policy" "managed_policy_with_user" {
  name        = "managed_policy_with_user"
  description = "A managed policy attached to user"
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
resource "aws_iam_policy" "managed_policy_with_role" {
  name        = "managed_policy_with_role"
  description = "A managed policy attached to role"
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
resource "aws_iam_policy_attachment" "attach_user" {
  name       = "managed_policy_attachment_to_user"
  users      = [aws_iam_user.user_with_managed_policy.name]
  policy_arn = aws_iam_policy.managed_policy_with_user.arn
}
resource "aws_iam_policy_attachment" "attach_role" {
  name       = "managed_policy_attachment_to_role"
  roles      = [aws_iam_user.role_with_managed_policy.name]
  policy_arn = aws_iam_policy.managed_policy_with_role.arn
}
