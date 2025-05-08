terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            configuration_aliases = [ aws.waf ]
        }
    }
}

resource "aws_wafv2_ip_set" "blocked_ips" {
    name               = "bips-${var.project_name}-${var.env}"
    scope              = "CLOUDFRONT"
    description        = "List of IPs to block ${var.project_name} - ${var.env}"
    ip_address_version = "IPV4"

    addresses = ["1.2.3.4/32"] # Example blocked IP

    tags = {
        Environment = "${var.env}"
    }
}

resource "aws_wafv2_web_acl" "waf" {
    name        = "fe-cf-waf-${var.project_name}-${var.env}"
    description = "Rules for the frontend cloudfront traffic. ${var.project_name}"
    scope       = "CLOUDFRONT"

    default_action {
        allow {}
    }

    rule {
        name     = "BlockBadIPs"
        priority = 1

        action {
            block {}
        }

        statement {
            ip_set_reference_statement {
                arn = aws_wafv2_ip_set.blocked_ips.arn
            }
        }

        visibility_config {
            cloudwatch_metrics_enabled = true
            metric_name                = "BlockBadIPsMetric"
            sampled_requests_enabled   = true
        }
    }

    rule {
        name     = "BlockRateLimit10000"
        priority = 2

        action {
            block {}
        }

        statement {
            rate_based_statement {
                limit              = 10000
                aggregate_key_type = "IP"
            }
        }

        visibility_config {
            cloudwatch_metrics_enabled = true
            metric_name                = "BlockRateLimit10000"
            sampled_requests_enabled   = false
        }
    }

    tags = {
        name = "fe-cf-waf-${var.project_name}-${var.env}"
    }

    visibility_config {
        cloudwatch_metrics_enabled = true
        metric_name                = "waf-cf-fe-${var.project_name}-${var.env}"
        sampled_requests_enabled   = true
    }

    depends_on = [aws_wafv2_ip_set.blocked_ips]
}

