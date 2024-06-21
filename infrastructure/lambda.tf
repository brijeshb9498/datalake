resource "aws_lambda_function" "process_data" {
  filename         = "process_data.zip"
  function_name    = "ProcessS3Files"
  role             = aws_iam_role.lambda_exec.arn
  handler          = "process_data.lambda_handler"
  runtime          = "python3.8"
  source_code_hash = filebase64sha256("process_data.zip")
}

resource "aws_lambda_permission" "allow_s3" {
  statement_id  = "AllowExecutionFromS3"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.process_data.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::data-lake-bucket"
}

resource "aws_s3_bucket_notification" "s3_notifications" {
  bucket = aws_s3_bucket.data_lake.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.process_data.arn
    events              = ["s3:ObjectCreated:*"]
  }
}

resource "aws_lambda_function" "onboarding" {
  filename         = "onboarding.zip"
  function_name    = "OnboardingHandler"
  role             = aws_iam_role.lambda_exec.arn
  handler          = "onboarding.lambda_handler"
  runtime          = "python3.8"
  source_code_hash = filebase64sha256("onboarding.zip")
}

