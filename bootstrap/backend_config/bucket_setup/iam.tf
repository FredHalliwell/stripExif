resource "aws_iam_policy" "tfstate_access" {
  name = "${var.environment}-tfstate-access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"]
        Resource = "arn:aws:s3:::${var.environment}-tfstate-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.region}-an/*"
      },
      {
        Effect   = "Allow"
        Action   = ["kms:*"]
        Resource = module.kms.key_arn
      },
      {
        Effect   = "Allow"
        Action   = ["kms:ListAliases"]
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_policy" "pipeline_policy" {
  name = "${var.environment}-pipeline-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:*"]
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = ["iam:CreateRole", "iam:GetRole"]
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = ["logs:*"]
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = ["lambda:*"]
        Resource = "*"
      }
    ]
  })
}