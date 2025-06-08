
# Environment
environment = "dev"

# AWS Provider Vars
region = "us-east-2"

# VPC Module Vars
vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.101.0/24", "10.0.102.0/24"]
public_azs           = ["us-east-2a", "us-east-2b"]
private_azs          = ["us-east-2a", "us-east-2b"]


# Security Groups Module Vars
alb_ingress_cidrs = ["0.0.0.0/0"]
app_port          = 80

# ECS Task Definition Vars
task_memory    = 512
task_cpu       = 256
container_port = 80
image_url      = "977099033170.dkr.ecr.us-east-2.amazonaws.com/my-php-app:v1.0.2"

# ECS Service Module Vars
desired_count = 2

# ECS Service and task definition Vars
container_name = "php-app"

# ECS Autoscaling Module Vars
min_capacity           = 2
max_capacity           = 5
target_cpu_utilization = 75
scale_in_cooldown      = 300
scale_out_cooldown     = 300


# RDS Module Vars **********************************************
#db_name        = (Sensible data included in secrets.auto.tfvars)
#db_username    = (Sensible data included in secrets.auto.tfvars)
#db_password    = (Sensible data included in secrets.auto.tfvars)
engine_version = "8.0.mysql_aurora.3.04.0"
instance_class = "db.t4g.medium"
instance_count = 2

# ElastiCache Module Vars
elasticache_engine_version = "6.2"
node_type                  = "cache.t3.micro"
num_cache_nodes            = 1

# ACM Module Vars (Domain needs to be registered in Route 53 to get the certificate) **********************************************
#domain_name     = (Sensible data included in secrets.auto.tfvars)
#route53_zone_id = (Sensible data included in secrets.auto.tfvars)

# Tags AWS Backup Module Vars
tags = {
  Service = "rds"
  Project = "Aura"
}