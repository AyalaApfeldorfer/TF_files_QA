resource "aws_cloudtrail" "my_aws_cloudtrail_connected_to_bucket_publicRead_failed" {
  name                          = "my_aws_cloudtrail"
  s3_bucket_name                =  aws_s3_bucket.my_aws_s3_bucket_publicRead
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.example.id

  block_public_acls   = false
  block_public_policy = false
}
