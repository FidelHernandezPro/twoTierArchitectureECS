
# AWS Provider Vars
variable "region" {
  description = "AWS region where the S3 bucket will be created"
  type        = string
}

# VPC Module Vars
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

# ALB  Vars
variable "alb_ingress_cidrs" {
  type = list(string)
}

variable "app_port" {
  type = number
}

variable "public_subnet_cidrs" {
  description = "CIDR block for the public subnet"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR block for the private subnet"
  type        = list(string)
}

variable "public_azs" {
  description = "Availability Zone for the public subnet"
  type        = list(string)
}

variable "private_azs" {
  description = "Availability Zone for the private subnet"
  type        = list(string)
}

#ECS Task definition vars
variable "task_memory" {}
variable "task_cpu" {}
variable "container_port" {}
variable "image_url" {}

# ECS Service Module Vars
variable "desired_count" {
  description = "Number of desired ECS tasks"
  type        = number
  default     = 1
}

# Service ECS Module Vars 
variable "container_name" {
  description = "Name of the container"
  type        = string
}

# ECS Autoscaling Module Vars
variable "min_capacity" {
  description = "Minimum number of ECS tasks"
  type        = number
}

variable "target_cpu_utilization" {
  description = "Target CPU utilization for ECS autoscaling"
  type        = number
}

variable "max_capacity" {
  description = "Maximum number of ECS tasks"
  type        = number
}

variable "scale_in_cooldown" {
  description = "Cooldown period (in seconds) after a scale-in activity"
  type        = number
}

variable "scale_out_cooldown" {
  description = "Cooldown period (in seconds) after a scale-out activity"
  type        = number
}


# RDS Module Variables
variable "db_name" {
  description = "Name of the RDS database"
  type        = string
}
variable "db_username" {
  description = "Username for the RDS database"
  type        = string
}
variable "db_password" {
  description = "Password for the RDS database"
  type        = string
  sensitive   = true
}

variable "engine_version" {
  description = "Database engine (e.g., mysql, postgres)"
  type        = string

}

variable "instance_class" {
  description = "Instance class for the RDS database"
  type        = string

}

variable "instance_count" {
  description = "Number of RDS instances"
  type        = number

}

# ElastiCache (Redis) Module Vars
variable "elasticache_engine_version" {
  description = "Redis engine version"
  type        = string

}

variable "node_type" {
  description = "Redis node instance type"
  type        = string

}
variable "num_cache_nodes" {
  description = "Number of cache nodes"
  type        = number

}

variable "domain_name" {
  description = "Domain for ACM certificate"
  type        = string
}


variable "route53_zone_id" {
  description = "Route 53 zone ID for DNS validation"
  type        = string
}


# Tags AWS Backup Module Vars 
variable "tags" {
  description = "Tags to apply to AWS Backup"
  type        = map(string)
}

# ecs task definition environment variables
variable "container_environment" {
  description = "List of environment variables for the container"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}