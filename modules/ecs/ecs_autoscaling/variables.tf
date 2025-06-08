variable "cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "service_name" {
  description = "Name of the ECS service"
  type        = string
}

variable "min_capacity" {
  description = "Minimum number of ECS tasks"
  type        = number
  default     = 2
}

variable "max_capacity" {
  description = "Maximum number of ECS tasks"
  type        = number
  default     = 5
}

variable "target_cpu_utilization" {
  description = "Target CPU utilization for ECS autoscaling"
  type        = number
  default     = 75
}

variable "scale_in_cooldown" {
  description = "Cooldown period (in seconds) after a scale-in activity"
  type        = number
  default     = 300
}

variable "scale_out_cooldown" {
  description = "Cooldown period (in seconds) after a scale-out activity"
  type        = number
  default     = 300
}
