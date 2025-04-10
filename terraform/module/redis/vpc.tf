resource "aws_elasticache_subnet_group" "redis_cluster_vpc" {
  name       = "redis-cluster-vpc"
  subnet_ids = var.vpc_subnets
}