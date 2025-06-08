resource "aws_elasticache_subnet_group" "this" {
  name       = "${var.environment}-redis-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name        = "${var.environment}-redis-subnet-group"
    Environment = var.environment
  }
}

resource "aws_elasticache_cluster" "this" {
  cluster_id           = "${var.environment}-redis-cluster"
  engine               = "redis"
  engine_version       = var.engine_version
  node_type            = var.node_type
  num_cache_nodes      = var.num_cache_nodes
  parameter_group_name = aws_elasticache_parameter_group.redis6.name
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.this.name
  security_group_ids   = var.security_group_ids

  tags = {
    Name        = "${var.environment}-redis"
    Environment = var.environment
  }
}

resource "aws_elasticache_parameter_group" "redis6" {
  name   = "${var.environment}-redis6-params"
  family = "redis6.x"
  description = "Parameter group for Redis 6"
}