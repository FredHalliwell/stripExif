# locals {
#   function_source = "modules/stripExif/function/lambda_function.zip"
# }

# resource "aws_s3_bucket" "builds" {
#   bucket = "lambdas"
# }

# resource "aws_s3_object" "stripExif" {
#   bucket = aws_s3_bucket.builds.id
#   key    = "${filemd5(local.function_source)}.zip"
#   source = local.function_source
# }

# module "lambda_function_existing_package_s3" {
#   source = "terraform-aws-modules/lambda/aws"

#   function_name = "stripExif"
#   description   = "Removes exif data from .jpg images."
#   handler       = "index.lambda_handler"
#   runtime       = "python3.12"

#   create_package = false
#   s3_existing_package = {
#     bucket = aws_s3_bucket.builds.id
#     key    = aws_s3_object.stripExif.id
#   }
# }

module "lambda_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket_namespace = "account-regional"

  bucket = format("${var.environment}-lambda-builds-%s-%s-an", data.aws_caller_identity.current.account_id, data.aws_region.current.region)
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }
}

module "stripExif_lambda" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "stripExif"
  description   = "Removes exif data from .jpg images."
  handler       = "index.lambda_handler"
  runtime       = "python3.12"
  publish       = true

  source_path = "modules/stripExif/function"

  store_on_s3 = true
  s3_bucket   = module.lambda_bucket.s3_bucket_id

#   layers = [
#     module.lambda_layer_s3.lambda_layer_arn,
#   ]

  environment_variables = {
    OUTPUT_BUCKET = module.s3_bucket_A.s3_bucket_id
  }

#   tags = {
#     Module = "lambda-with-layer"
#   }
}