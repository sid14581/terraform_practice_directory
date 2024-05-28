# input file
data "archive_file" "input_file" {
  type = "zip"
  source_file = "${path.module}/lambda_dir/"
  output_path = "${path.module}/lambda_dir/hello.zip"
}

# s3 bucket
resource "aws_s3_bucket" "lambda_bucket" {
  bucket = "damdam_bucket"
  tags = {
    Name = "damdam_bucket"
  }
}

# uploading file to s3 bucket
resource "aws_s3_object" "lambda_bucket_object" {
  bucket = aws_s3_bucket.lambda_bucket.id
  key = "hello.js"
  source = "${path.module}/lambda_dir/"
}

# iam role 
resource "aws_iam_role" "lambda_role" {
  name = "aws_lambda_role_full_access"
  assume_role_policy = file("terraform_practice_YT_Devs-\\aws_lambda_nodejs\\lambda_iam_role.json")
  # managed_policy_arns = [ aws_iam_policy.lambda_policy.arn ]
}

# iam policy
resource "aws_iam_policy" "lambda_policy" {
  name = "aws_lambda_policy_full_access"
  policy = file("terraform_practice_YT_Devs-\\aws_lambda_nodejs\\lambda_iam_role.json")
}

# resource "aws_iam_role_policy" "lambda_policy" {
#   name = "aws_lambda_policy_full_access"
#   policy = file("terraform_practice_YT_Devs-\\aws_lambda_nodejs\\lambda_iam_role.json")
#   role = aws_iam_role.lambda_role.id
# }

# Iam role policy attachment
resource "aws_iam_role_policy_attachment" "lambda_role" {
  role = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

# Lambda function
resource "aws_lambda_function" "testing_lambda" {
  function_name = "hello_lambda_file"
  filename = "${path.module}/lambda_dir/hello.zip"
  handler = hello.handler
  s3_bucket = aws_s3_bucket.lambda_bucket.id
  s3_key = "hello.zip"
  source_code_hash = data.archive_file.input_file.output_base64sha256
  runtime = "nodejs12.x"
  role = aws_iam_role.lambda_role.arn

  depends_on = [ aws_iam_role_policy_attachment.lambda_role ]
}


