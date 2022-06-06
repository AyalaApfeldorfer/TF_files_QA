resource "aws_cloudtrail" "my_aws_cloudtrail_connected_to_bucket_publicRead_failed" {
  name                          = "my_aws_cloudtrail"
  s3_bucket_name                = aws_s3_bucket.my_aws_s3_bucket_publicRead
  cloudwatch_log_group_name     = aws_cloudwatch_log_group.yada
}

resource "aws_s3_bucket" "my_aws_s3_bucket_publicRead" {
  acl = "public-read"
}

resource "aws_cloudwatch_log_group" "yada" {
  name = "Yada"

  tags = {
    Environment = "production"
    Application = "serviceA"
  }
}
