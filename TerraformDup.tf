  resource "aws_vpc" "my_vpc" {
    cidr_block = "172.16.0.0/16"
    enable_dns_hostnames = true

    tags = {
      Name = "tf-example"
    }
  }
  resource "aws_subnet" "my_subnet" {
    vpc_id            = aws_vpc.my_vpc.id
    cidr_block        = "172.16.10.0/24"
    availability_zone = "us-east-2a"
    tags = {
      Name = "tf-example"
    }
  }
  resource "aws_subnet" "my_subnet_1" {
    vpc_id            = aws_vpc.my_vpc.id
    cidr_block        = "172.16.20.0/24"
    availability_zone = "us-east-2b"
    tags = {
      Name = "tf-example-1"
    }
  }
  resource "aws_subnet" "my_subnet_2" {
    vpc_id            = aws_vpc.my_vpc.id
    cidr_block        = "172.16.30.0/24"
    availability_zone = "us-east-2c"
    tags = {
      Name = "tf-example-1"
    }
  }
  resource "aws_network_interface" "foo" {
    subnet_id   = aws_subnet.my_subnet.id
    private_ips = ["172.16.10.100"]
    tags = {
      Name = "primary_network_interface"
    }
  }
  resource "aws_network_interface" "boo" {
    subnet_id   = aws_subnet.my_subnet.id
    private_ips = ["172.16.10.101"]
    tags = {
      Name = "primary_network_interface"
    }
  }  
  resource "aws_instance" "foo" {
    ami           = "ami-0c6a6b0e75b2b6ce7" # us-west-2
    instance_type = "t2.micro"
    associate_public_ip_address = true
    network_interface {
      network_interface_id = aws_network_interface.foo.id
      device_index         = 0
    }
    vpc_security_group_ids = [aws_security_group.exposed_SG.id]
    credit_specification {
      cpu_credits = "unlimited"
    }
  }
  resource "aws_security_group" "exposed_SG" {
    description = "Allow inbound traffic to ElasticSearch from VPC CIDR"
    ingress {
      description = "TLS from VPC"
      cidr_blocks = ["0.0.0.0/0"]
      from_port = 0
      to_port = 6555
      protocol = "tcp"
    }
  }
  resource "aws_route_table" "example2" {
    vpc_id = aws_vpc.my_vpc.id
    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "igw-1111"
    }
    tags = {
      Name = "example"
    }
    depends_on = [aws_internet_gateway.igw-1111]
    }

  resource "aws_instance" "moo" {
    ami           = "ami-0c6a6b0e75b2b6ce7" # us-west-2
    instance_type = "t2.micro"
    associate_public_ip_address = true
    network_interface {
      network_interface_id = aws_network_interface.boo.id
      device_index         = 0
    }
    vpc_security_group_ids = [aws_security_group.exposed_SG_35.id]
    credit_specification {
      cpu_credits = "unlimited"
    }
    depends_on = [aws_security_group.exposed_SG_35]
  }
  resource "aws_security_group" "exposed_SG_35" {
    description = "Allow inbound traffic to ElasticSearch from VPC CIDR"
    ingress {
      description = "TLS from VPC"
      cidr_blocks = ["0.0.0.0/0"]
      from_port = 22
      to_port = 22
      protocol = "tcp"
    }
  }
  

  resource "aws_internet_gateway" "igw-1111" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "igw-1111"
  }
}

resource "aws_db_instance" "my_rds" {
  publicly_accessible    = true
  port = "3305"
  engine = "mysql"
  username             = "foo"
  password             = "foobarbaz"
  skip_final_snapshot  = true
  allocated_storage    = 10
  instance_class       = "db.t3.micro"
  db_subnet_group_name = aws_db_subnet_group.my_db_subnet_group.id
}
resource "aws_db_instance" "my_rds2" {
  publicly_accessible    = true
  port = "3306"
  engine = "mysql"
  skip_final_snapshot  = true
  allocated_storage    = 10
  username             = "foo"
  password             = "foobarbaz"
  instance_class       = "db.t3.micro"
  db_subnet_group_name = aws_db_subnet_group.my_db_subnet_group.id
}
# resource "aws_db_security_group" "my_db_security_group" {
#   name = "my_db_security_group"
#   ingress {
#     cidr = "0.0.0.0/0"
#   }
# }
resource "aws_security_group" "my_vpc_security_group" {
  name        = "my_vpc_security_group"
  ingress {
    description      = "TLS from VPC"
    from_port        = 3300
    to_port          = 3307
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}


resource "aws_db_subnet_group" "my_db_subnet_group" {
  name       = "main"
  subnet_ids = [aws_subnet.my_subnet.id, aws_subnet.my_subnet_1.id, aws_subnet.my_subnet_2.id]

  tags = {
    Name = "My DB subnet group"
  }
}


resource "aws_s3_bucket" "shift-left-terraform-test" {
  bucket = "shift-left-terraform-test"
}
resource "aws_s3_bucket_policy" "policy_for_bucket-with-only-policy-defined" {
  bucket = aws_s3_bucket.shift-left-terraform-test.id
  policy =<<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EnforcePrivate",
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:PutObjectACL",
      "Resource": "arn:aws:s3:::shift-left-terraform-test/*"
    },
    {
      "Sid": "EnforceTLSOnlyAccess",
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": [
        "arn:aws:s3:::shift-left-terraform-test/*",
        "arn:aws:s3:::shift-left-terraform-test"
      ],
      "Condition": {
        "Bool": {
          "aws:SecureTransport": "false"
        }
      }
    },
    {
      "Sid": "DenyCrossAccountAccessNoMFA",
      "Effect": "Deny",
      "Principal": {
        "AWS": "arn:aws:iam::241116592199:root"
      },
      "Action": "s3:*",
      "Resource": "arn:aws:s3:::shift-left-terraform-test",
      "Condition": {
        "BoolIfExists": {
          "aws:MultiFactorAuthPresent": "false"
        }
      }
    },
    {
      "Sid": "AllowCrossAccountAccess",
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "arn:aws:iam::241116592199:root",
          "arn:aws:iam::139114143232:root"
        ]
      },
      "Action": [
        "s3:ListBucket",
        "s3:ListBucketVersions",
        "s3:GetObjectVersion",
        "s3:GetBucketLocation",
        "s3:GetObject"
      ],
      "Resource": [
        "arn:aws:s3:::shift-left-terraform-test",
        "arn:aws:s3:::shift-left-terraform-test/*"
      ]
    },
    {
      "Sid": "PublicReadObject",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::shift-left-terraform-test/*"
    }
  ]
}
POLICY
}
resource "aws_s3_bucket_acl" "acl_for_shift-left-terraform-test" {
  bucket = aws_s3_bucket.shift-left-terraform-test.id
  access_control_policy {
owner {
    id = "348a860c3bb0443f94c6898617f9f2486df044d5ba4e3f45dd812095429afa9c"
  }
  grant {
      grantee {
        id = "348a860c3bb0443f94c6898617f9f2486df044d5ba4e3f45dd812095429afa9c"
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
    }
  grant {
      grantee {
        type = "Group"
        uri = "http://acs.amazonaws.com/groups/global/AllUsers"
      }
      permission = "READ"
    }
   }
  }
