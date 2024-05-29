# input file
data "archive_file" "inputfiles" {
  type        = "zip"
  source_file = "${path.module}/lambda_dir/hello.js"
  #source_dir = "${path.module}/lambda_dir/"
  output_path = "${path.module}/lambda_dir/hello.zip"
}

# s3 bucket
resource "aws_s3_bucket" "lambda-bucket" {
  bucket = "damdam-bucket"
  tags = {
    Name = "damdam-bucket"
  }
}

# uploading file to s3 bucket
resource "aws_s3_object" "lambda_bucket_object" {
  bucket = aws_s3_bucket.lambda-bucket.id
  key    = "hello.js"
  source = "${path.module}/lambda_dir/"
}

# iam role 
resource "aws_iam_role" "lambda_role" {
  name = "aws_lambda_role_full_access"
  # managed_policy_arns = [ aws_iam_policy.lamebda_policy.arn ]
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# iam policy
resource "aws_iam_policy" "lambda_policy" {
  name   = "aws_lambda_policy_full_access"
  policy = <<-EOF
  {
    "Version" : "2012-10-17",
    "Statement" : [{
        "Effect" : "Allow",
        "Action" : [
            "s3:*",
            "logs:*"
        ],
        "Resource" : "*"
    }]
}
EOF
}

# resource "aws_iam_role_policy" "lambda_policy" {
#   name = "aws_lambda_policy_full_access"
#   policy = file("terraform_practice_YT_Devs-\\aws_lambda_nodejs\\lambda_iam_role.json")
#   role = aws_iam_role.lambda_role.id
# }

# Iam role policy attachment
resource "aws_iam_role_policy_attachment" "lambda_role" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

# Lambda function
resource "aws_lambda_function" "testing_lambda" {
  function_name    = "hello_lambda_file"
  handler          = "hello.handler"
  #s3_bucket        = aws_s3_bucket.lambda-bucket.id
  #s3_key           = "hello.zip"
  filename         = "${path.module}/lambda_dir/hello.zip"
  source_code_hash = data.archive_file.inputfiles.output_base64sha256
  runtime          = "nodejs18.x"
  role             = aws_iam_role.lambda_role.arn

  depends_on = [aws_iam_role_policy_attachment.lambda_role]
}

