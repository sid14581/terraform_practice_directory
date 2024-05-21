# Provider
provider "aws" {
  region = "us-east-1"
}

# Data IAM Role
data "aws_iam_policy_document" "assume_role" {
  version = "2012-10-17"
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

# IAM Role
resource "aws_iam_role" "lambda_role" {
  name               = "lambda_role_created_using_terraform"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# IAM Policy
resource "aws_iam_policy" "lambda_policy" {
  name        = "lambda_policy_created_using_terraform"
  path        = "/"
  description = "lambda_policy created using terraform"
  policy      = <<-EOF
        {
            "Version": "2012-10-17",
            "Statement": [
                "Effect": "Allow"
                "Resource": "arn:aws:logs:*:*:*",
                "Action": [
                    "logs:CreateLogGroup"
                    "logs:CreateLogStream"
                    "logs:PutLogEvents"
                ]
            ] 
        }
  EOF
}

# IAM Role Policy Attachment
resource "aws_iam_role_policy_attachment" "lambda_policy_role" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

# Data python file
data "archive_file" "lambda_zip_file" {
  type        = "zip"
  source_dir  = "${path.module}/python/"
  output_path = "${path.module}/python/hello-python.zip"
}

# Lambda Function
resource "aws_lambda_function" "terraform_lambda_function" {
  filename      = "${path.module}/python/hello-python.zip"
  function_name = "tf_function_lambda"
  role          = aws_iam_role.lambda_role.arn
  handler       = "hello-python.lambda_handler"
  runtime       = "python3.8"
  depends_on    = [aws_iam_role_policy_attachment.lambda_policy_role]
}

# Output
output "terraform_Aws_role_output" {
  value = aws_iam_role.lambda_role.name
}
output "terraform_aws_role_arn_output" {
  value = aws_iam_role.lambda_role.arn
}
output "terraform_logging_policy_output" {
  value = aws_iam_policy.lambda_policy.name
}

output "terraform_logging_arn_output" {
  value = aws_iam_policy.lambda_policy.arn
}