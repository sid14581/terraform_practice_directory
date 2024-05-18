provider "aws" {
  region = "us-east-1"
  access_key = 
  secret_key = 
}

resource "aws_s3_bucket" "basic-storage" {
  bucket = "basic-buckets"
  tags = {
    Name = "yo"
  }
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "damdam_versioning" {
  bucket = aws_s3_bucket.basic-storage.id
  versioning_configuration {
    status = "Enabled"
  }
} 

resource "aws_s3_bucket_server_side_encryption_configuration" "damdam-encryption" {
  bucket = aws_s3_bucket.basic-storage.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "terraform_dyna_locks" {
  name = "basestatelock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
