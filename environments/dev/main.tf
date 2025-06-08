

# Module for creating a VPC with public private subnets and NAT gateway.
module "vpc" {
  source               = "../../modules/network/vpc"
  vpc_cidr             = var.vpc_cidr
  environment          = var.environment
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  public_azs           = var.public_azs
  private_azs          = var.private_azs
}

# Module for creating security groups for the VPC, ECS, RDS (MySQL), ElastiCache (Redis), and an ALB/NLB.
module "security_groups" {
  source            = "../../modules/security/security_groups"
  vpc_id            = module.vpc.vpc_id
  environment       = var.environment
  alb_ingress_cidrs = var.alb_ingress_cidrs
  app_port          = var.app_port
}

# Module for creating an Application Load Balancer (ALB)
module "alb" {
  source             = "../../modules/network/alb"
  environment        = var.environment
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  alb_sg_id          = module.security_groups.alb_sg_id
  target_port        = var.app_port

}

# # Module for creating a Network Load Balancer (NLB)
module "nlb" {
  source = "../../modules/network/nlb"

  environment       = var.environment
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
}


# Module for creating the ECS Cluster
module "ecs_cluster" {
  source      = "../../modules/ecs/ecs-cluster"
  environment = var.environment
}

# IAM Role used by ECS to pull images from ECR 
module "ecs_task_execution_role" {
  source      = "../../modules/iam/ecs_task_execution_role"
  environment = var.environment
}

# Task definition module for the ECS task definition.
module "ecs_task_definition" {
  source      = "../../modules/ecs/task_definition"
  environment = var.environment
  container_environment = [
    {
      name  = "RDS_HOST"
      value = module.rds.cluster_endpoint
    },
    {
      name  = "RDS_DB"
      value = module.rds.db_name
    },
    {
      name  = "RDS_USER"
      value = module.rds.username
    },
    {
      name  = "RDS_PASS"
      value = module.rds.password
    },
    {
      name  = "REDIS_HOST"
      value = module.elasticache.primary_endpoint
    }
  ]
  
  image_url          = var.image_url
  task_role_arn      = module.ecs_task_execution_role.task_role_arn
  execution_role_arn = module.ecs_task_execution_role.ecs_task_execution_arn
  task_memory        = var.task_memory
  task_cpu           = var.task_cpu
  container_port     = var.container_port
  container_name     = var.container_name
}

# Module for creating the ECS service
module "ecs_service" {
  source               = "../../modules/ecs/service"
  environment          = var.environment
  cluster_id           = module.ecs_cluster.cluster_id
  task_definition_arn  = module.ecs_task_definition.task_definition_arn
  container_port       = module.ecs_task_definition.container_port
  desired_count        = var.desired_count
  subnet_ids           = module.vpc.private_subnet_ids
  security_group_ids   = [module.security_groups.ecs_sg_id]
  alb_listener         = module.alb.listener_arn
  container_name       = var.container_name
  alb_target_group_arn = module.alb.target_group_arn
}

# Module for creating ECS autoscaling policies
module "ecs_autoscaling" {
  source = "../../modules/ecs/ecs_autoscaling"

  cluster_name           = module.ecs_service.cluster_id
  service_name           = module.ecs_service.service_name
  min_capacity           = var.min_capacity
  max_capacity           = var.max_capacity
  target_cpu_utilization = var.target_cpu_utilization
  scale_in_cooldown      = var.scale_in_cooldown
  scale_out_cooldown     = var.scale_out_cooldown
}


# Module for creating a Lambda function that syncs ALB and NLB target groups.
module "alb_nlb_sync_lambda" {
  source               = "../../modules/utils/alb-to-nlb-sync-lambda"
  environment          = var.environment
  alb_dns_name         = module.alb.alb_dns_name
  nlb_target_group_arn = module.nlb.target_group_arn
}

# RDS Module for creating an Amazon RDS instance (MySQL).
module "rds" {
  source             = "../../modules/rds"
  environment        = var.environment
  db_name            = var.db_name
  db_username        = var.db_username
  db_password        = var.db_password
  engine_version     = var.engine_version
  instance_class     = var.instance_class
  instance_count     = var.instance_count
  subnet_ids         = module.vpc.private_subnet_ids
  subnet_group_name  = module.db_subnet_group.subnet_group_name
  security_group_ids = [module.security_groups.rds_sg_id]
}

# Module for creating a DB Subnet Group for RDS
module "db_subnet_group" {
  source      = "../../modules/rds/db_subnet_group"
  environment = var.environment
  subnet_ids  = module.vpc.private_subnet_ids
}

# Module for creating an ElastiCache (Redis) cluster.
module "elasticache" {
  source             = "../../modules/elasticache"
  environment        = var.environment
  subnet_ids         = module.vpc.private_subnet_ids
  security_group_ids = [module.security_groups.elasticache_sg_id]
  engine_version     = var.elasticache_engine_version
  node_type          = var.node_type
  num_cache_nodes    = var.num_cache_nodes
}

# Module for creating an ACM (AWS Certificate Manager) certificate for the domain.
module "acm" {
  source          = "../../modules/acm"
  domain_name     = var.domain_name
  route53_zone_id = var.route53_zone_id
  environment     = var.environment

  providers = {
    aws = aws.us_east_1
  }
}

# Module for creating a CloudFront distribution to serve content from the NLB.
module "cloudfront" {
  source              = "../../modules/cloudfront"
  environment         = var.environment
  domain_name         = var.domain_name
  origin_domain_name  = module.nlb.nlb_dns_name
  acm_certificate_arn = module.acm.certificate_arn
  web_acl_id          = module.waf.web_acl_arn
}

# Module for creating a WAF (Web Application Firewall) to protect the ALB.
module "waf" {
  source      = "../../modules/waf"
  environment = var.environment

  providers = {
    aws = aws.us_east_1
  }

}

# Module for creating AWS Backup resources.
module "aws_backup" {
  source          = "../../modules/aws_backup"
  environment     = var.environment
  tags            = var.tags
  rds_arn         = module.rds.db_instance_arn
  backup_role_arn = module.backup_iam_role.role_arn
}

# Module for creating an IAM role for AWS Backup.
module "backup_iam_role" {
  source      = "../../modules/iam/backup_role"
  name_prefix = var.environment
}

# CloudWatch Dashboard module for monitoring resources.
module "cloudwatch_dashboard" {
  source = "../../modules/cloudwatch_dashboard"

  environment      = var.environment
  region           = var.region
  ecs_cluster_name = module.ecs_cluster.cluster_name
  ecs_service_name = module.ecs_service.service_name
  rds_cluster_id   = module.rds.cluster_id
  redis_cluster_id = module.elasticache.cache_cluster_id
  alb_name         = module.alb.arn_suffix
  nlb_name         = module.nlb.arn_suffix
}

# SSM Parameters module for storing sensitive information.
module "ssm_secrets" {
  source     = "../../modules/ssm_parameters"
  environment = var.environment
  parameters = {
    "/myapp/db_name"        = var.db_name
    "/myapp/db_username"    = var.db_username
    "/myapp/db_password"    = var.db_password
    "/myapp/domain_name"    = var.domain_name
    "/myapp/route53_zone_id" = var.route53_zone_id
  }
}
