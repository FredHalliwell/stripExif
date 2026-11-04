locals {
  function_source = "function/stripExif.zip"
}

resource "aws_s3_bucket" "builds" {
  bucket = "lambdas"
  acl    = "private"
}

resource "aws_s3_object" "stripExif" {
  bucket = aws_s3_bucket.builds.id
  key    = "${filemd5(local.function_source)}.zip"
  source = local.function_source
}

module "lambda_function_existing_package_s3" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "stripExif"
  description   = "Removes exif data from .jpg images."
  handler       = "index.lambda_handler"
  runtime       = "python3.12"

  create_package      = false
  s3_existing_package = {
    bucket = aws_s3_bucket.builds.id
    key    = aws_s3_object.stripExif.id
  }
}