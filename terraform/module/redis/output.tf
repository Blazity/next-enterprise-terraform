output "redis_cluster_master_node_url" {
    value       = aws_elasticache_cluster.redis_cluster.cache_nodes[0].address
    description = "The addess of redis node"
}
