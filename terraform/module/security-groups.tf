resource "aws_security_group" "frontend_load_balancer_security_group" {
    description = "Security group for ${var.project_name} for frontend ALB"
    vpc_id      = aws_vpc.vpc.id

    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
  
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "frontend_service_security_group" {
    description = "Security group for ${var.project_name} for frontend ECS"
    vpc_id      = aws_vpc.vpc.id

    ingress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        security_groups = ["${aws_security_group.frontend_load_balancer_security_group.id}"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}