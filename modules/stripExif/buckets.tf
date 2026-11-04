data "aws_caller_identity" "current" {}
data "aws_region" "current" {}


module "s3_bucket_A" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = format("${var.environment}-bucket-a-%s-%s-an", data.aws_caller_identity.current.account_id, data.aws_region.current.region)
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }
}

module "s3_bucket_B" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = format("${var.environment}-bucket-b-%s-%s-an", data.aws_caller_identity.current.account_id, data.aws_region.current.region)
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }
}
