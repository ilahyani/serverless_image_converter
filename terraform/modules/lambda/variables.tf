variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "runtime" {
  description = "Lambda function runtime"
  type        = string
  default     = "nodejs"
}

variable "handler" {
  description = "Lambda function handler"
  type        = string
  default     = "index.handler"
}

variable "lambda_src_code" {
  description = "Path to Lambda function zip file"
  type        = string
}

variable "lambda_zip" {
  description = "Path to Lambda function zip file"
  type        = string
}

variable "original_files_bucket_name" {
  description = "Name of the bucket where the original files are stored"
  type = string
}

variable "edited_files_bucket_name" {
  description = "Name of the bucket where the watermaked files are stored"
  type = string
}

variable "original_files_bucket_arn" {
  description = "ARN of the bucket where original files are stored"
  type = string
}