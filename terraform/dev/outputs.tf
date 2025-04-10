output "frontend_ecr_repo_name" {
    description = "The name of the ECR frontend repository"
    value       = module.app_infra.frontend_ecr_repo_name
}

output "redis_cluster_master_node_url" {
    description = "The URL to Redis node"
    value       = module.redis_cluster.redis_cluster_master_node_url
}

output "frontend_alb_dns_name" {
    description = "The URL to frontend ALB dns"
    value       = module.app_infra.frontend_alb_dns_name
}

output "s3_storybook_website_endpoint" {
    description = "The storybook bucket website endpoint"
    value       = module.s3_bucket.s3_storybook_bucket_website_endpoint
}

output "cloudfront_frontend_domain_name" {
    description = "Cloudfront frontend domain name"
    value       = module.cloudfront.cloudfront_frontend_domain_name
}

output "cloudfront_frontend_distribution_id" {
    description = "Cloudfront distribution id"
    value = module.cloudfront.cloudfront_frontend_distribution_id
}