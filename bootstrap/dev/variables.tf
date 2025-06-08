
variable "region" {
  description = "AWS region where the S3 bucket will be created"
  type        = string
}

variable "bucket_name" {
  description = "Name of the S3 bucket for storing Terraform state"
  type        = string
}

variable "environment" {
  description = "Deployment environment like dev, staging, prod"
  type        = string
}