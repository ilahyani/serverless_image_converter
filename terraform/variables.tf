##### PROVIDER
variable "aws_access_key" {
  type        = string
}

variable "aws_secret_key" {
  type        = string
}

variable "AWS_REGION" {
  type        = string
}

variable "aws_profile" {
  type        = string
}

##### LAMBDA
variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "lambda_runtime" {
  description = "Lambda function runtime"
  type        = string
  default     = "nodejs20.x"
}

variable "lambda_handler" {
  description = "Lambda function handler"
  type        = string
  default     = "index.handler"
}

variable "lambda_src_code" {
  description = "Path to Lambda business logic"
  type        = string
}

variable "lambda_zip" {
  description = "Path to Lambda function zip file"
  type        = string
}

##### S3
variable "original_files_bucket_name" {
  description = "Name of the bucket where the original files are stored"
  type = string
}

variable "edited_files_bucket_name" {
  description = "Name of the bucket where the watermaked files are stored"
  type = string
}
