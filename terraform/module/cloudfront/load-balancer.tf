resource "aws_cloudfront_distribution" "frontend_load_balancer" {
    origin {
        domain_name  = var.frontend_alb_dns_name
        origin_id    = var.frontend_alb_name

        custom_origin_config {
            http_port = "80"
            https_port = "443"
            origin_protocol_policy = "http-only"
            origin_read_timeout    = "60"
            origin_ssl_protocols   = ["TLSv1.2", "TLSv1.1", "TLSv1"]
        }
    }

    enabled             = true
    is_ipv6_enabled     = true

    default_cache_behavior {
        allowed_methods  = ["HEAD", "GET"]
        cached_methods   = ["GET", "HEAD"]
        target_origin_id = var.frontend_alb_name
        cache_policy_id  = "83da9c7e-98b4-4e11-a168-04f0df8e2c65"
        origin_request_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3"

        viewer_protocol_policy = "allow-all"
        min_ttl                = 0
        default_ttl            = 3600
        max_ttl                = 86400
    }

    # Cache behavior with precedence 0
    ordered_cache_behavior {
        viewer_protocol_policy = "redirect-to-https"
        path_pattern     = "/*.js"
        allowed_methods  = ["GET", "HEAD"]
        cached_methods   = ["GET", "HEAD"]
        target_origin_id = var.frontend_alb_name
        cache_policy_id  = "658327ea-f89d-4fab-a63d-7e88639e58f6"
        origin_request_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3"
    }

    # Cache behavior with precedence 1
    ordered_cache_behavior {
        viewer_protocol_policy = "redirect-to-https"
        path_pattern     = "/*.jpg"
        allowed_methods  = ["GET", "HEAD"]
        cached_methods   = ["GET", "HEAD"]
        target_origin_id = var.frontend_alb_name
        cache_policy_id  = "658327ea-f89d-4fab-a63d-7e88639e58f6"
        origin_request_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3"
    }

    # Cache behavior with precedence 2
    ordered_cache_behavior {
        viewer_protocol_policy = "redirect-to-https"
        path_pattern     = "/*.jpeg"
        allowed_methods  = ["GET", "HEAD"]
        cached_methods   = ["GET", "HEAD"]
        target_origin_id = var.frontend_alb_name
        cache_policy_id  = "658327ea-f89d-4fab-a63d-7e88639e58f6"
        origin_request_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3"
    }

    # Cache behavior with precedence 3
    ordered_cache_behavior {
        viewer_protocol_policy = "redirect-to-https"
        path_pattern     = "/*.png"
        allowed_methods  = ["GET", "HEAD"]
        cached_methods   = ["GET", "HEAD"]
        target_origin_id = var.frontend_alb_name
        cache_policy_id  = "658327ea-f89d-4fab-a63d-7e88639e58f6"
        origin_request_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3"
    }

    # Cache behavior with precedence 4
    ordered_cache_behavior {
        viewer_protocol_policy = "redirect-to-https"
        path_pattern     = "/*.webp"
        allowed_methods  = ["GET", "HEAD"]
        cached_methods   = ["GET", "HEAD"]
        target_origin_id = var.frontend_alb_name
        cache_policy_id  = "658327ea-f89d-4fab-a63d-7e88639e58f6"
        origin_request_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3"
    }

    # Cache behavior with precedence 5
    ordered_cache_behavior {
        viewer_protocol_policy = "redirect-to-https"
        path_pattern     = "/*.css"
        allowed_methods  = ["GET", "HEAD"]
        cached_methods   = ["GET", "HEAD"]
        target_origin_id = var.frontend_alb_name
        cache_policy_id  = "658327ea-f89d-4fab-a63d-7e88639e58f6"
        origin_request_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3"
    }

    # Cache behavior with precedence 2
    ordered_cache_behavior {
        viewer_protocol_policy = "redirect-to-https"
        path_pattern     = "/*.gif"
        allowed_methods  = ["GET", "HEAD"]
        cached_methods   = ["GET", "HEAD"]
        target_origin_id = var.frontend_alb_name
        cache_policy_id  = "658327ea-f89d-4fab-a63d-7e88639e58f6"
        origin_request_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3"
    }

    price_class = "PriceClass_200"

    restrictions {
        geo_restriction {
            restriction_type = "none"
            locations        = []
        }
    }

    tags = {
        Environment = var.env
    }

    web_acl_id = var.frontend_waf_arn

    viewer_certificate {
        cloudfront_default_certificate = true
    }
}