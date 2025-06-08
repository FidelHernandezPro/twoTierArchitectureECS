variable "environment" {
  description = "Environment name (e.g. dev, staging, prod)"
  type        = string
}

variable "subnet_ids" {
  description = "List of private subnet IDs for Redis"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs for Redis"
  type        = list(string)
}

variable "engine_version" {
  description = "Redis engine version"
  type        = string
  default     = "7.x"
}

variable "node_type" {
  description = "Redis node instance type"
  type        = string
}

variable "num_cache_nodes" {
  description = "Number of cache nodes"
  type        = number
  default     = 1
}

# variable "primary_endpoint_address" {
#   description = "Primary endpoint address of the Redis cluster"
#   type        = string
#   default     = ""
# }