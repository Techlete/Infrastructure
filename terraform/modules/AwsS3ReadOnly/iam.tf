# IAM user granting Read-only access to a bucket
resource "aws_iam_user" "priv_user" {
  name        = "user_${var.bucket_name}"
}

resource "aws_iam_access_key" "priv_user" {
  user        = aws_iam_user.priv_user.name
  depends_on  = [aws_iam_user.priv_user]
}

resource "aws_iam_policy" "user_permission" {
  name        = "${aws_iam_user.priv_user.name}_to_s3_bucket"
  path        = "/"
  description = "Grant ${aws_iam_user.priv_user.name} access to ${var.bucket_name}"

  policy = <<CONFIG
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetObject",
        "s3:ListBucket",
        "s3:GetBucketLocation"
      ],
      "Effect": "Allow",
      "Resource": [
        var.bucket_arn,
        "${var.bucket_arn}/*"
      ]
    }
  ]
}
CONFIG
  depends_on  = [aws_iam_user.priv_user]
}

resource "aws_iam_policy_attachment" "user_attach" {
  name        = "attach_${aws_iam_user.priv_user.name}_to_${var.bucket_name}"
  users       = [aws_iam_user.priv_user.name]
  policy_arn  = aws_iam_policy.user_permission.arn

  depends_on  = [aws_iam_user.priv_user]
}
