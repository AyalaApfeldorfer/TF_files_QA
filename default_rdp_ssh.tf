 resource "aws_security_group" "default" {
  vpc_id = aws_vpc.mainvpc.id


  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 3389
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  }
