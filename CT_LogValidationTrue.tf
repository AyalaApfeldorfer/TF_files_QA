resource "aws_cloudtrail" "my_aws_cloudtrail_connected_to_bucket_publicRead_failed" {
  name                          = "my_aws_cloudtrail"
  s3_bucket_name                = aws_s3_bucket.my_aws_s3_bucket_publicRead
}
resource "aws_s3_bucket" "my_aws_s3_bucket_publicRead" {
  acl = "public-write"
}
