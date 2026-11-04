module "user_B" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"

  name = "user.B"

  force_destroy           = true
  pgp_key                 = "keybase:test"
  password_reset_required = false
}

resource "aws_iam_user_policy" "readWriteBucketB" {
  name   = "read-write-bucket-B"
  user   = module.user_B.name
  policy = aws_iam_policy.readWriteBucketB.policy
}

resource "aws_iam_policy" "readWriteBucketB" {
  name = "${var.environment}-read-write-bucket-B"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = "ReadBucketB"
        Effect   = "Allow"
        Action   = ["s3:ListBucket", "s3:GetBucketLocation"]
        Resource = module.s3_bucket_B.s3_bucket_arn
      },
    ]
  })
}