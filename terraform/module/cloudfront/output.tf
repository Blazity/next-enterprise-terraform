output "cloudfront_frontend_domain_name" {
    value = aws_cloudfront_distribution.frontend_load_balancer.domain_name
}

output "cloudfront_frontend_distribution_id" {
    value = aws_cloudfront_distribution.frontend_load_balancer.id
}