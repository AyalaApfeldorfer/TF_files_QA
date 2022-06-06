resource "aws_cloudtrail" "my_aws_cloudtrail_connected_to_bucket_publicRead_failed" {
  name                          = "my_aws_cloudtrail"
  s3_bucket_name                = aws_s3_bucket.my_aws_s3_bucket_publicRead
  kms_key_name                  = aws_kms_key.a
}
resource "aws_s3_bucket" "my_aws_s3_bucket_publicRead" {
  acl = "public-read"
}
resource "aws_kms_key" "a" {
  description             = "KMS key 1"
  deletion_window_in_days = 10
}
