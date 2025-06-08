variable "environment" {}
variable "region" {}

variable "ecs_cluster_name" {}
variable "ecs_service_name" {}

variable "rds_cluster_id" {}
variable "redis_cluster_id" {}

variable "alb_name" {
  description = "Name of the ALB from CloudWatch format: app/load-balancer-name/hash"
}
variable "nlb_name" {
  description = "Name of the NLB from CloudWatch format: net/load-balancer-name/hash"
}
