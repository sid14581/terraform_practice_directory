
# data IAM Role
data "aws_iam_policy_document" "data_role_lambda" {
  version = "2012-10-17"
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = [ "lambda.amazonaws.com" ]
    }
  }
}

# Iam Role
resource "aws_iam_role" "role_lambda" {
  name = var.role_name
  assume_role_policy = data.aws_iam_policy_document.data_role_lambda.json
}

# Iam Policy
resource "aws_iam_policy" "policy_lambda" {
  name        = var.policy_name
  description = "S3 full Access"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

# Role policy attachment
resource "aws_iam_role_policy_attachment" "policy_role_attach" {
  role =  aws_iam_role.role_lambda.name
  policy_arn = aws_iam_policy.policy_lambda.arn
}

# data archive
data "archive_file" "file_s3" {
  type = "zip"
  source_dir = "${path.module}/Python_Lambda/"
  output_path = "${path.module}/Python_Lambda/list_buckets.zip"
}

# lambda function
resource "aws_lambda_function" "test_lambda" {
  filename = "${path.module}/Python_Lambda/list_buckets.zip"  
  function_name = var.function_name
  handler = "list_buckets.get_s3_buckets"
  role = aws_iam_role.role_lambda.arn
  runtime = "python3.11"
  depends_on = [ aws_iam_role_policy_attachment.policy_role_attach ]
  source_code_hash = data.archive_file.file_s3.output_base64sha256
   
  environment {
    variables = {
      foo = "bar"
    }
  }
}

# Output
output "terraform_Aws_role_output" {
  value = aws_iam_role.role_lambda.name
}
output "terraform_aws_role_arn_output" {
  value = aws_iam_role.role_lambda.arn
}
output "terraform_logging_policy_output" {
  value = aws_iam_policy.policy_lambda.name
}

output "terraform_logging_arn_output" {
  value = aws_iam_policy.policy_lambda.arn
}
