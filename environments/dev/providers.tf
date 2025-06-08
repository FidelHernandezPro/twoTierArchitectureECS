
terraform {
  required_version = ">= 1.12.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  # Default provider for AWS resources in the specified region.
  region = var.region
}
# Provider for AWS resources in us-east-1, used for ACM and CloudFront.
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}
