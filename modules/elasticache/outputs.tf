# output "primary_endpoint" {
#   value = aws_elasticache_replication_group.this.primary_endpoint_address
# }

output "primary_endpoint" {
  value = aws_elasticache_cluster.this.cache_nodes[0].address
}

output "redis_port" {
  value = aws_elasticache_cluster.this.cache_nodes[0].port
}

output "cache_cluster_id" {
  value = aws_elasticache_cluster.this.id
}