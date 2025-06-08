variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}


variable "environment" {
  description = "Deployment environment (e.g., dev, staging, prod)"
  type        = string
}



variable "public_subnet_cidrs" {
  type = list(string)
}

variable "private_subnet_cidrs" {
  type = list(string)
}

variable "public_azs" {
  type = list(string)
}

variable "private_azs" {
  type = list(string)
}
