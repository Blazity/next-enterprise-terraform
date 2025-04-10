resource "aws_cloudwatch_log_group" "ecs_frontend" {
    name = "${var.project_name}-${var.env}-ecs-frontend"
    retention_in_days = var.logs_retention_in_days

    tags = {
        Environment = var.env
        Project     = var.project_name
    }
}