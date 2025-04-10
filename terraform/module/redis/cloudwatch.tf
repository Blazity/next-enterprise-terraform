resource "aws_cloudwatch_log_group" "redis_cluster" {
    name = var.elasticache_cluster_name
    retention_in_days = var.logs_retention_in_days

    tags = {
        Environment = var.env
        Application = var.elasticache_cluster_name
    }
}