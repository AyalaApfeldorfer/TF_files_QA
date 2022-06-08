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
resource "aws_iam_policy" "policy" {
  name        = "AWSSupportAccess"
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
resource "aws_iam_policy_attachment" "attach_role" {
  name       = "managed_policy_attachment_to_role"
  roles      = [aws_iam_user.role.name]
  policy_arn = aws_iam_policy.policy.arn
}
