variable "cluster_id" {}
variable "task_definition_arn" {}
variable "desired_count" {}
variable "subnet_ids" {
  type = list(string)
}
variable "security_group_ids" {
  type = list(string)
}
# variable "target_group_arn" {}
variable "container_port" {}
variable "alb_listener" {}

variable "environment" {
  description = "Deployment environment (e.g., dev, staging, prod)"
  type        = string
}

variable "container_name" {
  description = "Name of the container"
  type        = string
}



variable "alb_target_group_arn" {
  type = string
}


