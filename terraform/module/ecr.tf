resource "aws_ecr_repository" "frontend_ecr_repo" {
    name = "${var.project_name}-fe-${var.env}"
    image_tag_mutability = "MUTABLE"
    force_delete = true
    
    tags = {
        Environment = var.env
        Project     = var.project_name
    }

    image_scanning_configuration {
        scan_on_push = true
    }
}

resource "aws_ecr_lifecycle_policy" "frontend_ecr_repo_policy" {
    repository = aws_ecr_repository.frontend_ecr_repo.name
    policy     = <<EOF
    {
        "rules": [
            {
                "rulePriority": 1,
                "description": "Keep last ${var.env == "prod" ? 2 : 1} images",
                "selection": {
                    "tagStatus": "tagged",
                    "tagPrefixList": ["${var.project_name}-${var.env}"],
                    "countType": "imageCountMoreThan",
                    "countNumber": ${var.env == "prod" ? 2 : 1}
                },
                "action": {
                    "type": "expire"
                }
            }
        ]
    }
    EOF
}