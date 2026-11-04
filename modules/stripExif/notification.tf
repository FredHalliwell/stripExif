resource "aws_s3_bucket_notification" "image_uploaded" {
  bucket = module.s3_bucket_A.s3_bucket_id

  lambda_function {
    lambda_function_arn = module.stripExif_lambda.lambda_function_arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "AWSLogs/"
    filter_suffix       = ".log"
  }

  depends_on = [aws_lambda_permission.allow_bucket]
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = module.stripExif_lambda.lambda_function_arn
  principal     = "s3.amazonaws.com"
  source_arn    = module.s3_bucket_A.s3_bucket_arn
}