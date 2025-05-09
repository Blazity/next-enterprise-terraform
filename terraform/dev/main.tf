provider "aws" {
	region = "eu-west-2"
}

provider "aws" {
	alias  = "waf"
	region = "us-east-1"
}

data "aws_region" "current" {}

locals {
    project_name = "next-enterprise-iac"
}

module "app_infra" {
	source           = "../module"
	region 			 = data.aws_region.current.name
	project_name     = local.project_name
	node_env         = "development"
	env              = "dev"
	desired_count    = 1
	docker_image_tag = var.docker_image_tag
	logs_retention_in_days = 30
	redis_url = module.redis_cluster.redis_cluster_master_node_url
}

module "ecs_frontend_auto_scaling" {
	env = "dev"
	source = "../module/ecs-auto-scaling"
	project_name = local.project_name
	ecs_cluster = module.app_infra.ecs_cluster
	ecs_service = module.app_infra.frontend_ecs_service
}

module "redis_cluster" {
	env = "dev"
	source = "../module/redis"
	project_name = local.project_name
	logs_retention_in_days = 30
	elasticache_cluster_name = "${local.project_name}-dev-redis-cluster"
	elasticache_cluster_node_type = "cache.t4g.micro"
	elasticache_cluster_num_cache_nodes = 1
	vpc_id = module.app_infra.vpc_id
	vpc_subnets = module.app_infra.vpc_public_subnets
	ingress_security_group_id = module.app_infra.frontend_ecs_task_security_group_id
}

module "waf" {
	env = "dev"
	source = "../module/waf"
	project_name = local.project_name

	providers = {
    	aws = aws.waf
		aws.waf  = aws.waf
  	}
}

module "s3_bucket" {
	env = "dev"
	source = "../module/s3"
	s3_storybook_name = "${local.project_name}-storybook"
	s3_storybook_cors_domains = ["storybook.the-app-custom-domain.com"]
}

module "cloudfront" {
	env = "dev"
	source = "../module/cloudfront"
	project_name = local.project_name

	frontend_waf_arn = module.waf.frontend_waf_arn
	frontend_alb_dns_name = module.app_infra.frontend_alb_dns_name
	frontend_alb_name = module.app_infra.frontend_alb_name
}