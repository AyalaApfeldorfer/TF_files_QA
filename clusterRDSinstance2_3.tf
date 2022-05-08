resource "aws_rds_cluster_instance" "my_rds_cluster_instance2" {
  publicly_accessible    = true
  cluster_identifier = aws_rds_cluster.my_rds_cluster.id

}

resource "aws_rds_cluster_instance" "my_rds_cluster_instance3" {
  publicly_accessible    = true
  cluster_identifier = aws_rds_cluster.my_rds_cluster.id

}