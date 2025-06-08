
# Backend S3 bucket and DynamoDB table for Terraform state locking
resource "aws_s3_bucket" "backend_s3_bucket" {
  bucket = var.bucket_name 
}

resource "aws_s3_bucket_versioning" "versioning_enabled" {
  bucket = var.bucket_name
  versioning_configuration {
    status = "Enabled"

  }
}

# Create a DynamoDB table for state locking
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "${var.bucket_name}-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Environment = var.environment
    Terraform   = "lock-table"
  }

  depends_on = [aws_s3_bucket.backend_s3_bucket]
}



terraform {
  backend "s3" {}
}