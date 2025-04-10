output "frontend_ecr_repo_name" {
    value       = aws_ecr_repository.frontend_ecr_repo.name
    description = "The name of the ECR Frontend repository"
}

output "ecs_cluster" {
    value = aws_ecs_cluster.ecs_cluster
}

output "frontend_ecs_service" {
    value = aws_ecs_service.frontend_ecs
}

output "vpc_id" {
    value = aws_vpc.vpc.id
}

output "vpc_public_subnets" {
    value = [
        aws_subnet.public_subnet_a.id,
        aws_subnet.public_subnet_b.id,
        aws_subnet.public_subnet_c.id
    ]
}

output "vpc_private_subnets" {
    value = [
        aws_subnet.private_subnet_a.id,
        aws_subnet.private_subnet_b.id,
        aws_subnet.private_subnet_c.id
    ]
}

output "frontend_ecs_task_security_group_id" {
    value = aws_security_group.frontend_service_security_group.id
}

output "frontend_alb_dns_name" {
    value = aws_alb.frontend_load_balancer.dns_name
}

output "frontend_alb_name" {
    value = aws_alb.frontend_load_balancer.name
}