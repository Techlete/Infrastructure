resource "aws_s3_bucket" "bucket" {

  bucket      = var.bucket_name
  acl         = var.acl

  tags        = var.tags

  versioning {
    enabled = var.enable_versioning
  }

  cors_rule {
    allowed_headers = var.cors_allowed_headers
    allowed_methods = var.cors_allowed_methods
    allowed_origins = var.cors_allowed_origins
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}

resource "aws_s3_bucket_policy" "bucket_ses_policy" {
  count  = length(var.ses_push_account_ids)
  bucket = aws_s3_bucket.bucket.id
  policy = <<CONFIG
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowSESPuts",
            "Effect": "Allow",
            "Principal": {
                "Service": "ses.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "${aws_s3_bucket.bucket.arn}/*",
            "Condition": {
                "StringEquals": {
                    "aws:Referer": "${var.ses_push_account_ids[count.index]}"
                }
            }
        }
    ]
}
CONFIG
  depends_on = [aws_s3_bucket.bucket]
}