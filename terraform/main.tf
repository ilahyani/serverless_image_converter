terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    bucket = "tf-backendd"
    key = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "ft-state"
  }
}

provider "aws" {
  profile    = var.aws_profile
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.AWS_REGION
}

module "s3_original_files_bucket" {
    source = "./modules/s3"
    bucket_name = var.original_files_bucket_name
}

module "s3_edited_files_bucket" {
    source = "./modules/s3"
    bucket_name = var.edited_files_bucket_name
}

module "lambda" {
    source = "./modules/lambda"

    function_name = var.lambda_function_name
    runtime = var.lambda_runtime
    handler = var.lambda_handler
    lambda_src_code = var.lambda_src_code
    lambda_zip = var.lambda_zip
    original_files_bucket_name = var.original_files_bucket_name
    original_files_bucket_arn = module.s3_original_files_bucket.bucket_arn
    edited_files_bucket_name = var.edited_files_bucket_name
}
