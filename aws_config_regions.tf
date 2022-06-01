resource "aws_iam_group" "group" {
  name = "test-group"
}

resource "aws_iam_policy_attachment" "test-attach" {
  name       = "test-attachment"
  groups     = [aws_iam_group.group.name]
  policy_arn = aws_iam_policy.policy.arn
}
