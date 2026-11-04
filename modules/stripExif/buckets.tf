module "s3_bucket_A" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "bucket_A"
  acl    = "public"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }
}

module "s3_bucket_B" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "bucket_B"
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }
}