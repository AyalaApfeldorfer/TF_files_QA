
resource "aws_cloudtrail" "my_aws_cloudtrail_not_connected_to_bucket_passed" {
  name                          = "my_aws_cloudtrail"
 
}

resource "aws_cloudtrail" "my_aws_cloudtrail_connected_to_bucket_publicRead_failed" {
  name                          = "my_aws_cloudtrail"
  s3_bucket_name                = aws_s3_bucket.my_aws_s3_bucket_publicRead
}

resource "aws_s3_bucket" "my_aws_s3_bucket_publicRead" {
  acl = "public-read"
}

resource "aws_cloudtrail" "my_aws_cloudtrail_connected_to_bucket_publicReadWrite_failed" {
  name                          = "my_aws_cloudtrail"
  s3_bucket_name                = aws_s3_bucket.my_aws_s3_bucket_publicReadWrite
}

resource "aws_s3_bucket" "my_aws_s3_bucket_publicReadWrite" {
  acl = "public-read-write"
}

resource "aws_cloudtrail" "my_aws_cloudtrail_connected_to_bucket_not_public_passed" {
  name                          = "my_aws_cloudtrail"
  s3_bucket_name                = aws_s3_bucket.my_aws_s3_bucket_not_public
}

resource "aws_s3_bucket" "my_aws_s3_bucket_not_public" {
  acl = "private"
}

resource "aws_cloudtrail" "my_aws_cloudtrail_connected_to_bucket_connected_to_acl_publicRead_failed" {
  name                          = "my_aws_cloudtrail"
  s3_bucket_name                = aws_s3_bucket.my_aws_s3_bucket_connected_to_acl_publicRead
}

resource "aws_s3_bucket" "my_aws_s3_bucket_connected_to_acl_publicRead" {
 
}

resource "aws_s3_bucket_acl" "my_aws_s3_bucket_acl_publicRead" {
  bucket = aws_s3_bucket.my_aws_s3_bucket_connected_to_acl_publicRead
  acl    = "public-read"
}

resource "aws_cloudtrail" "my_aws_cloudtrail_connected_to_bucket_connected_to_acl_publicReadWrite_failed" {
  name                          = "my_aws_cloudtrail"
  s3_bucket_name                = aws_s3_bucket.my_aws_s3_bucket_connected_to_acl_publicReadWrite
}

resource "aws_s3_bucket" "my_aws_s3_bucket_connected_to_acl_publicReadWrite" {
 
}

resource "aws_s3_bucket_acl" "my_aws_s3_bucket_acl_publicReadWrite" {
  bucket = aws_s3_bucket.my_aws_s3_bucket_connected_to_acl_publicReadWrite.id
  acl    = "public-read-write"
}

resource "aws_cloudtrail" "my_aws_cloudtrail_connected_to_bucket_connected_to_acl_not_public_passed" {
  name                          = "my_aws_cloudtrail"
  s3_bucket_name                = aws_s3_bucket.my_aws_s3_bucket_connected_to_acl_not_public
}

resource "aws_s3_bucket" "my_aws_s3_bucket_connected_to_acl_not_public" {
 
}

resource "aws_s3_bucket_acl" "my_aws_s3_bucket_acl_not_public" {
  bucket = aws_s3_bucket.my_aws_s3_bucket_connected_to_acl_not_public.id
  acl    = "private"
}

resource "aws_cloudtrail" "my_aws_cloudtrail_connected_to_bucket_without_any_acl_passed" {
  name                          = "my_aws_cloudtrail"
  s3_bucket_name                = aws_s3_bucket.my_aws_s3_bucket_without_any_acl
}

resource "aws_s3_bucket" "my_aws_s3_bucket_without_any_acl" {
 
}
