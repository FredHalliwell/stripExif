module "user_A" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"

  name = "user.A"

  force_destroy           = true
  pgp_key                 = "keybase:test"
  password_reset_required = false
}

resource "aws_iam_user_policy" "readWriteBucketA" {
  name   = "read-write-bucket-A"
  user   = module.user_A.iam_user_name
  policy = aws_iam_policy.readWriteBucketA.policy
}

resource "aws_iam_policy" "readWriteBucketA" {
  name = "${var.environment}-read-write-bucket-A"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = "read-bucket-A"
        Effect   = "Allow"
        Action   = ["s3:ListBucket", "s3:GetBucketLocation"]
        Resource = module.s3_bucket_A.s3_bucket_arn
      },
      {
        Sid      = "write-bucket-A"
        Effect   = "Allow"
        Action   = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"]
        Resource = "${module.s3_bucket_A.s3_bucket_arn}/*"
      }
    ]
  })
}