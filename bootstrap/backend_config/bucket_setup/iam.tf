resource "aws_iam_policy" "tfstate_access" {
  name = "dev-tfstate-access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"]
        Resource = "arn:aws:s3:::dev-tfstate-${data.aws_caller_identity.current.account_id}-${var.region}-an/*"
      },
      {
        Effect   = "Allow"
        Action   = ["kms:Decrypt", "kms:Encrypt", "kms:GenerateDataKey"]
        Resource = module.kms.key_arn
      }
    ]
  })
}