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
      gateway_id = aws_internet_gateway.igw-1111.id
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

resource "aws_flow_log" "example" {
  log_destination      = aws_s3_bucket.example.arn
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.my_vpc.id
  destination_options {
    file_format        = "parquet"
    per_hour_partition = true
  }
}

resource "aws_s3_bucket" "example" {
  bucket = "example"
}