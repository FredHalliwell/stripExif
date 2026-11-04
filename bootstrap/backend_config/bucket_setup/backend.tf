data "aws_caller_identity" "current" {}
data "aws_region" "current" {}


resource "aws_s3_bucket" "tfstate" {
  bucket           = format("${var.environment}-tfstate-%s-%s-an", data.aws_caller_identity.current.account_id, data.aws_region.current.region)
  bucket_namespace = "account-regional"
}

output "tfstate_bucket_name" {
  value      = aws_s3_bucket.tfstate.bucket
  depends_on = [aws_s3_bucket.tfstate]
}