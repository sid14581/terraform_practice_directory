terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.0"
    }
  }
  backend "s3" {
    bucket         = "basic-buckets"
    key            = "tf-state-files/web-app/terraform.tfstate"
    region         = "ca-central-1"
    dynamodb_table = "basestatelock"
    encrypt        = true
  }
}