output "bucket_arn" {
  description = "ARN of the Lambda function"
  value       = aws_s3_bucket.bucket.arn
}
