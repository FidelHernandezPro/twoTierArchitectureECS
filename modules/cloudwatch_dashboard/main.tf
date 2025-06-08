resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "${var.environment}-infra-dashboard"
  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric",
        x    = 0,
        y    = 0,
        width = 6,
        height = 6,
        properties = {
          title = "ECS CPU",
          metrics = [
            [ "AWS/ECS", "CPUUtilization", "ClusterName", var.ecs_cluster_name, "ServiceName", var.ecs_service_name ]
          ],
          view = "timeSeries",
          stat = "Average",
          region = var.region
        }
      },
      {
        type = "metric",
        x    = 6,
        y    = 0,
        width = 6,
        height = 6,
        properties = {
          title = "ECS Memory",
          metrics = [
            [ "AWS/ECS", "MemoryUtilization", "ClusterName", var.ecs_cluster_name, "ServiceName", var.ecs_service_name ]
          ],
          view = "timeSeries",
          stat = "Average",
          region = var.region
        }
      },
      {
        type = "metric",
        x    = 0,
        y    = 6,
        width = 6,
        height = 6,
        properties = {
          title = "RDS CPU Utilization",
          metrics = [
            [ "AWS/RDS", "CPUUtilization", "DBClusterIdentifier", var.rds_cluster_id ]
          ],
          region = var.region
        }
      },
      {
        type = "metric",
        x    = 6,
        y    = 6,
        width = 6,
        height = 6,
        properties = {
          title = "Redis CPU Utilization",
          metrics = [
            [ "AWS/ElastiCache", "CPUUtilization", "CacheClusterId", var.redis_cluster_id ]
          ],
          region = var.region
        }
      },
      {
        type = "metric",
        x    = 0,
        y    = 12,
        width = 6,
        height = 6,
        properties = {
          title = "ALB Request Count",
          metrics = [
            [ "AWS/ApplicationELB", "RequestCount", "LoadBalancer", var.alb_name ]
          ],
          region = var.region
        }
      },
      {
        type = "metric",
        x    = 6,
        y    = 12,
        width = 6,
        height = 6,
        properties = {
          title = "NLB Active Connections",
          metrics = [
            [ "AWS/NetworkELB", "ActiveFlowCount", "LoadBalancer", var.nlb_name ]
          ],
          region = var.region
        }
      }
    ]
  })
}
