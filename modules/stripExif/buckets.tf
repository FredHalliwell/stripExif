module "s3_bucket_A" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "bucket-a"
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }
}

module "s3_bucket_B" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "bucket-b"
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }
}