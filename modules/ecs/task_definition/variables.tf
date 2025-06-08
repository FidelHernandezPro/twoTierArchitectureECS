variable "task_cpu" {}
variable "task_memory" {}
variable "task_role_arn" {}
variable "container_port" {}
variable "container_env_vars" {
  type    = list(object({ name = string, value = string }))
  default = []
}

variable "environment" {
  description = "Deployment environment (e.g., dev, staging, prod)"
  type        = string
}

variable "container_environment" {
  type = list(object({
    name  = string
    value = string
  }))
  description = "Environment variables for the container"
  default     = []
}

variable "image_url" {
  type        = string
  description = "URI of the container image in ECR"
}

variable "execution_role_arn" {
  type        = string
  description = "IAM role ARN for ECS task execution"
}

variable "container_name" {
  description = "Name of the container"
  type        = string
}

# variable "container_secrets" {
#   description = "Secrets to inject from SSM Parameter Store"
#   type        = list(object({
#     name      = string
#     valueFrom = string
#   }))
#   default     = []
# }
