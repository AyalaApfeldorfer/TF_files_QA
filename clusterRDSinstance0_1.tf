resource "aws_rds_cluster_instance" "my_rds_cluster_instance" {
  publicly_accessible    = true
  cluster_identifier = aws_rds_cluster.my_rds_cluster.id

}

resource "aws_rds_cluster_instance" "my_rds_cluster_instance1" {
  publicly_accessible    = true
  cluster_identifier = aws_rds_cluster.my_rds_cluster.id

}

resource "aws_rds_cluster" "my_rds_cluster" {
  engine                  = "aurora-mysql"
  vpc_security_group_ids = [aws_security_group.my_vpc_security_group.id]
  db_subnet_group_name = aws_db_subnet_group.my_db_subnet_group
}



resource "aws_security_group" "my_vpc_security_group" {
  name        = "my_vpc_security_group" 
  id = "sg-12345678"

  ingress {
    description      = "TLS from VPC"
    from_port        = 3305
    to_port          = 3307
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

}

resource "aws_db_subnet_group" "my_db_subnet_group" {
  name       = "my_db_subnet_group"
  subnet_ids = [aws_subnet.my_subnet.id]
}

resource "aws_subnet" "my_subnet" {
    vpc_id     = aws_vpc.my_vpc.id
}

resource "aws_route_table_association" "my_route_table_association" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.my_route_table.id
}

resource "aws_route_table" "my_route_table" {
  vpc_id     = aws_vpc.my_vpc2.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "igw-"
  }

}

resource "aws_vpc" "my_vpc" {

}


resource "aws_vpc" "my_vpc2" {

}