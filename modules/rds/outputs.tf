output "cluster_endpoint" {
  value = aws_rds_cluster.this.endpoint
}

output "db_name" {
  value = aws_rds_cluster.this.database_name
}

output "username" {
  value = aws_rds_cluster.this.master_username
}

output "password" {
  value = aws_rds_cluster.this.master_password  # If not hardcoded, consider retrieving from Secrets Manager
}

output "reader_endpoint" {
  value = aws_rds_cluster.this.reader_endpoint
}

output "engine_version" {
  value = aws_rds_cluster.this.engine_version
}

output "db_instance_arn" {
  value = aws_rds_cluster_instance.this[0].arn
}

output "cluster_id" {
  value = aws_rds_cluster.this.id
}