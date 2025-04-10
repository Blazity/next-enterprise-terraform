resource "aws_alb" "frontend_load_balancer" {
    name               = "${var.project_name}-fe-lb-${var.env}"
    load_balancer_type = "application"
    subnets = [
        "${aws_subnet.public_subnet_a.id}",
        "${aws_subnet.public_subnet_b.id}",
        "${aws_subnet.public_subnet_c.id}"
    ]
    security_groups = ["${aws_security_group.frontend_load_balancer_security_group.id}"]
}

resource "aws_lb_target_group" "frontend_target_group" {
    name        = "${var.project_name}-fe-tg-${var.env}"
    port        = 80
    protocol    = "HTTP"
    target_type = "ip"
    vpc_id      = aws_vpc.vpc.id

    health_check {
        matcher             = "200,301,302"
        path                = "/"
        interval            = 300
        timeout             = 120
        unhealthy_threshold = 5
    }
}

resource "aws_lb_listener" "frontend_http" {
    load_balancer_arn = aws_alb.frontend_load_balancer.arn
    port              = "80"
    protocol          = "HTTP"

    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.frontend_target_group.arn
    }
}