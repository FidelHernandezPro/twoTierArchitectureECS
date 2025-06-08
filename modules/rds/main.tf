resource "aws_rds_cluster" "this" {
  cluster_identifier      = "${var.environment}-aurora-cluster"
  engine                  = "aurora-mysql"
  engine_mode             = "provisioned"
  engine_version          = var.engine_version
  database_name           = var.db_name
  master_username         = var.db_username
  master_password         = var.db_password
  db_subnet_group_name    = var.subnet_group_name
  vpc_security_group_ids  = var.security_group_ids
  backup_retention_period = 7
  preferred_backup_window = "03:00-04:00"
  skip_final_snapshot     = true
}

resource "aws_rds_cluster_instance" "this" {
  count                   = var.instance_count
  identifier              = "${var.environment}-aurora-instance-${count.index + 1}"
  cluster_identifier      = aws_rds_cluster.this.id
  instance_class          = var.instance_class
  engine                  = aws_rds_cluster.this.engine
  engine_version          = aws_rds_cluster.this.engine_version
  publicly_accessible     = false
}

