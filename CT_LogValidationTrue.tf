resource "aws_iam_account_password_policy" "noAllow" {
  minimum_password_length        = 9
  require_lowercase_characters   = true
  require_numbers                = true
  require_uppercase_characters   = true
  require_symbols                = true
  password_reuse_prevention = 24
  max_password_age = 90
}
