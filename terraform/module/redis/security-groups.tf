resource "aws_security_group" "redis_cluster" {
    description = "Security group for ${var.elasticache_cluster_name}"
    vpc_id      = var.vpc_id

    ingress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        security_groups = ["${var.ingress_security_group_id}"]
    }
}