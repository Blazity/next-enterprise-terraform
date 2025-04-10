resource "aws_elasticache_cluster" "redis_cluster" {
    cluster_id                 = var.elasticache_cluster_name
    engine                     = "redis"
    node_type                  = var.elasticache_cluster_node_type
    num_cache_nodes            = var.elasticache_cluster_num_cache_nodes
    parameter_group_name       = "default.redis7"
    engine_version             = "7.1"
    port                       = 6379
    apply_immediately          = true
    # transit_encryption_enabled = true - not yet supported by AWS CLI
    subnet_group_name          = aws_elasticache_subnet_group.redis_cluster_vpc.name 
    security_group_ids         = [aws_security_group.redis_cluster.id]

    log_delivery_configuration {
        destination      = aws_cloudwatch_log_group.redis_cluster.name
        destination_type = "cloudwatch-logs"
        log_format       = "text"
        log_type         = "slow-log"
    }
}