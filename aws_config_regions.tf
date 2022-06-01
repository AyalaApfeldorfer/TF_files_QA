resource "aws_iam_role" "role" {
  name = "test-role"
}

resource "aws_iam_policy_attachment" "test-attach" {
  name       = "test-attachment"
  roles      = [aws_iam_role.role.name]
  policy_arn = aws_iam_policy.policy.arn
}
