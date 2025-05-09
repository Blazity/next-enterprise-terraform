resource "aws_elasticache_subnet_group" "redis_cluster_vpc" {
  name       = "${var.project_name}-redis-${var.env}"
  subnet_ids = var.vpc_subnets
}