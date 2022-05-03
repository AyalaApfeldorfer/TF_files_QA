// bucket with only acl defined

resource "aws_s3_bucket" "bucket-with-only-acl-defined" {
  bucket = "bucket-with-only-acl-defined-name"
}

resource "aws_s3_bucket_acl" "acl_for_bucket-with-only-acl-defined" {
  bucket = aws_s3_bucket.bucket-with-only-acl-defined.id
  access_control_policy {
    grant {
      grantee {
        type = "Group"
        uri  = "http://acs.amazonaws.com/groups/global/AllUsers"
      }
      permission = "WRITE_ACP"
    }
    grant {
      grantee {
        type = "Group"
        uri = "http://acs.amazonaws.com/groups/global/AllUsers"
      }
      permission = "READ"
    }
    grant {
      grantee {
        type = "Group"
        uri = "http://acs.amazonaws.com/groups/global/AllUsers"
      }
      permission = "WRITE"
    }

    owner {
      id = data.aws_canonical_user_id.current.id
    }
  }
}

resource "aws_s3_bucket_public_access_block" "pab_for_bucket-with-full-definition" {
  bucket = aws_s3_bucket.bucket-with-only-acl-defined.id

  block_public_acls   = false
  ignore_public_acls = true
  block_public_policy = true
  restrict_public_buckets = false
}
