variable "elasticache_cluster_name" {
    type = string
}

variable "elasticache_cluster_node_type" {
    type = string
}

variable "elasticache_cluster_num_cache_nodes" {
    type = number
}

variable "logs_retention_in_days" {
    type = number
}

variable "vpc_subnets" {
    type = list(string)
}

variable "vpc_id" {
    type = string
}

variable "env" {
    type = string
}

variable "ingress_security_group_id" {
    type = string
}

variable "project_name" {
    type = string
}
