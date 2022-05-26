resource "aws_iam_account_password_policy" "my_passowdPolicy_should_fail" {
  minimum_password_length        = 8
  require_lowercase_characters   = false
  require_numbers                = false
  require_uppercase_characters   = false
  require_symbols                = false
  allow_users_to_change_password = true
  max_password_age  = 92
  password_reuse_prevention =23
}

resource "aws_security_group" "security_group_rdp_should_fail_1" {

  ingress {
    description      = "TLS from VPC"
    from_port        = 3388
    to_port          = 3390
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "security_group_rdp_should_fail_2" {

  ingress {
    description      = "TLS from VPC"
    from_port        = 3388
    to_port          = 3392
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

}


resource "aws_security_group" "security_group_not_rdp_should_pass" {

  ingress {
    description      = "TLS from VPC"
    from_port        = 3390
    to_port          = 3390
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

}
