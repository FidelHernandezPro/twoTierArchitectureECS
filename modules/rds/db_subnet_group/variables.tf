variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "subnet_ids" {
  description = "List of private subnet IDs for the DB subnet group"
  type        = list(string)
}
