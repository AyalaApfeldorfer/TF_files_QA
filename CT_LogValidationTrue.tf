resource "aws_iam_account_password_policy" "noAllow" {
  minimum_password_length        = 9
  require_lowercase_characters   = false
  require_numbers                = true
  require_uppercase_characters   = true
  require_symbols                = true
  password_reuse_prevention = 3
  max_password_age = 12
}
resource "aws_iam_account_password_policy" "noReuse" {
  minimum_password_length        = 6
  require_lowercase_characters   = true
  require_numbers                = false
  require_uppercase_characters   = true
  require_symbols                = true
  allow_users_to_change_password = false
  max_password_age = 0
}
resource "aws_iam_account_password_policy" "noMax" {
  minimum_password_length        = 6
  require_lowercase_characters   = true
  require_numbers                = true
  require_uppercase_characters   = true
  require_symbols                = false
  allow_users_to_change_password = false
  password_reuse_prevention = 3
  }
