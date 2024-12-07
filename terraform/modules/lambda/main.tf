resource "aws_lambda_function" "converter" {
    filename = data.archive_file.lambda_zip.output_path
    function_name = var.function_name
    role = aws_iam_role.lambda_exec_role.arn
    handler = var.handler
    runtime = var.runtime
    source_code_hash = filebase64sha256(data.archive_file.lambda_zip.output_path)
    environment {
      variables = {
        edited_files_bucket_name = var.edited_files_bucket_name
      }
    }
}

resource "aws_iam_role" "lambda_exec_role" {
    name = "${var.function_name}-exec-role"
    assume_role_policy = jsonencode({
        Statement = [{
            Action = "sts:AssumeRole"
            Effect = "Allow"
            Principal = {
                Service = "lambda.amazonaws.com"
            }
        }]
    })
}

resource "aws_iam_role_policy" "lambda_permissions_policy" {
    name = "${var.function_name}-permissions-policy"
    role = aws_iam_role.lambda_exec_role.name
    policy = jsonencode({
        Statement = [
            {
                Action   = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"]
                Effect   = "Allow"
                Resource = "*"
            },
            {
                Resource = [
                    "arn:aws:s3:::${var.original_files_bucket_name}/*",
                    "arn:aws:s3:::${var.edited_files_bucket_name}/*"
                ]
                Action = ["s3:GetObject", "s3:PutObject", "s3:ListBucket"]
                Effect = "Allow"
            },
        ]
    })
}

resource "aws_s3_bucket_notification" "image_upload_notification" {
    bucket = var.original_files_bucket_name

    lambda_function {
        events = ["s3:ObjectCreated:*"] 
        lambda_function_arn = "${aws_lambda_function.converter.arn}"
    }

    depends_on = [aws_lambda_function.converter]
}

resource "aws_lambda_permission" "allow_s3_invoke" {
    statement_id  = "AllowExecutionFromS3Bucket"
    action        = "lambda:InvokeFunction"
    principal     = "s3.amazonaws.com"
    source_arn    = var.original_files_bucket_arn
    function_name = aws_lambda_function.converter.function_name
    depends_on = [aws_lambda_function.converter]
}

data "archive_file" "lambda_zip" {
    type        = "zip"
    source_dir = var.lambda_src_code
    output_path  = var.lambda_zip
}