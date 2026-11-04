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

  function_name = "${var.environment}-stripExif"
  description   = "Removes exif data from .jpg images."
  handler       = "index.lambda_handler"
  runtime       = "python3.12"
  publish       = true

  source_path = "modules/stripExif/function"

  store_on_s3 = true
  s3_bucket   = module.lambda_bucket.s3_bucket_id

  layers = [
    # from https://github.com/keithrozario/Klayers#list-of-arns
    "arn:aws:lambda:eu-west-2:770693421928:layer:Klayers-p312-pillow:2"
  ]

  environment_variables = {
    OUTPUT_BUCKET = module.s3_bucket_B.s3_bucket_id
  }

  attach_policy_statements = true
  policy_statements = {
    s3_read = {
      effect    = "Allow"
      actions   = ["s3:GetObject", "s3:ListBucket"]
      resources = ["${module.s3_bucket_A.s3_bucket_arn}/*"]
    },
    s3_write = {
      effect    = "Allow"
      actions   = ["s3:PutObject"]
      resources = ["${module.s3_bucket_B.s3_bucket_arn}/*"]
    }
  }
}