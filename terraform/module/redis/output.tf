output "redis_cluster_master_node_url" {
    value       = aws_elasticache_cluster.redis_cluster.cluster_address
    description = "The addess of redis node"
}
