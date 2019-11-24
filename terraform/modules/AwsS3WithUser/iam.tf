
# IAM user for accessing the bucket
resource "aws_iam_user" "iam_user" {
  count       = var.create_user ? 1 : 0
  name        = "${var.bucket_name}_user"
}

resource "aws_iam_access_key" "access_key" {
  count       = var.create_user ? 1 : 0
  user        = aws_iam_user.iam_user[0].name
  depends_on = [aws_iam_user.iam_user[0]]
}

resource "aws_iam_policy" "bucket_user_policy" {
  count       = var.create_user ? 1 : 0
  name        = "${aws_iam_user.iam_user[0].name}_to_${var.bucket_name}_s3_bucket"
  path        = "/"
  description = "Grant ${aws_iam_user.iam_user[0].name} access to ${var.bucket_name}"

  policy = <<CONFIG
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "s3:*",
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.bucket.arn}",
        "${aws_s3_bucket.bucket.arn}/*"
      ]
    }
  ]
}
CONFIG
  depends_on = [aws_iam_user.iam_user[0], aws_s3_bucket.bucket]
}

resource "aws_iam_policy_attachment" "policy_user_attach" {
  count       = var.create_user ? 1 : 0
  name       = "attach_${aws_iam_user.iam_user[0].name}_to_${var.bucket_name}"
  users      = ["${aws_iam_user.iam_user[0].name}"]
  policy_arn = aws_iam_policy.bucket_user_policy[0].arn
  depends_on = [aws_iam_user.iam_user[0],aws_iam_policy.bucket_user_policy[0]]
}