resource "aws_s3_bucket" "bucket-with-only-policy-defined" {
  bucket = "bucket-with-only-policy-defined-name"
}

resource "aws_s3_bucket_policy" "policy_for_bucket-with-only-policy-defined" {
  bucket = aws_s3_bucket.bucket-with-only-policy-defined.id
  policy =<<POLICY
{
  "Version": "2012-10-17",
  "Id": "MYBUCKETPOLICY",
  "Statement": [
    {
      "Sid": "IPAllow",
      "Effect": "Allow",
      "Principal": "*",
      "Action": ["bla", "s3:PutBucketAcl"],
      "Resource": ["arn:aws:s3:::bucket-with-only-policy-defined-name", "blu"],
      "Condition": {
      }
    },
    {
      "Sid": "IPAllow",
      "Effect": "Allow",
      "Principal": "*",
      "Action": ["bla", "s3:ListBucket"],
      "Resource": ["arn:aws:s3:::bucket-with-only-policy-defined-name/*", "blu"],
      "Condition": {
      }
    },
{
      "Sid": "IPAllow",
      "Effect": "Allow",
      "Principal": "*",
      "Action": ["bla", "s3:GetObject"],
      "Resource": ["arn:aws:s3:::bucket-with-only-policy-defined-name/*", "blu"],
      "Condition": {
      }
    },
{
      "Sid": "IPAllow",
      "Effect": "Allow",
      "Principal": "*",
      "Action": ["bla", "s3:PutObject"],
      "Resource": ["arn:aws:s3:::bucket-with-only-policy-defined-name/*", "blu"],
      "Condition": {
      }
    }
  ]
}
POLICY
}

resource "aws_s3_bucket_public_access_block" "pab_for_bucket-with-full-definition" {
  bucket = aws_s3_bucket.bucket-with-only-policy-defined.id

  block_public_acls   = true
  ignore_public_acls = false
  block_public_policy = true
  restrict_public_buckets = true
}