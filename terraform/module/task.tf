resource "aws_ecs_cluster" "ecs_cluster" {
    name = "${var.project_name}-cluster-${var.env}"
}

resource "aws_ecs_task_definition" "frontend_ecs_task" {
    family                   = "${var.project_name}-fe-${var.env}"
    container_definitions    = <<DEFINITION
    [
        {
            "name": "${var.project_name}-fe-${var.env}",
            "image": "${aws_ecr_repository.frontend_ecr_repo.repository_url}:${var.docker_image_tag}",
            "essential": true,
            "environment": [
                {
                    "name": "NODE_ENV",
                    "value": "${var.node_env}"
                },
                {
                    "name": "REDIS_URL",
                    "value": "redis://${var.redis_url}:6379"
                }
            ],
            "portMappings": [
                {
                    "containerPort": 3000,
                    "hostPort": 3000
                }
            ],
            "logConfiguration": {
                "logDriver": "awslogs",
                "options": {
                    "awslogs-group": "${aws_cloudwatch_log_group.ecs_frontend.name}",
                    "awslogs-region": "eu-west-2",
                    "awslogs-stream-prefix": "${var.project_name}-"
                }
            },
            "memory": 2048,
            "cpu": 1024
        }
    ]
    DEFINITION
    requires_compatibilities = ["FARGATE"]
    network_mode             = "awsvpc"
    memory                   = 2048
    cpu                      = 1024
    execution_role_arn       = aws_iam_role.task_execution_role.arn
    task_role_arn            = aws_iam_role.task_role.arn
}

resource "aws_ecs_service" "frontend_ecs" {
    name            = "${var.project_name}-fe-${var.env}"
    cluster         = aws_ecs_cluster.ecs_cluster.id
    task_definition = aws_ecs_task_definition.frontend_ecs_task.arn
    launch_type     = "FARGATE"
    desired_count   = var.desired_count

    load_balancer {
        target_group_arn = aws_lb_target_group.frontend_target_group.arn
        container_name   = aws_ecs_task_definition.frontend_ecs_task.family
        container_port   = 3000
    }

    network_configuration {
        subnets          = ["${aws_subnet.public_subnet_a.id}", "${aws_subnet.public_subnet_b.id}", "${aws_subnet.public_subnet_c.id}"]
        assign_public_ip = true
        security_groups  = ["${aws_security_group.frontend_service_security_group.id}"]
    }

    lifecycle {
        ignore_changes = [desired_count]
    }
}