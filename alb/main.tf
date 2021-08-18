### Load Balancer
resource "aws_lb" "alb" {
    count              = var.create_alb == true ? 1 : 0
    name               = "${var.project_id}-${var.env}-lb"
    internal           = var.internal 
    load_balancer_type = var.load_balancer_type 
    security_groups    = var.security_groups 
    subnets            = var.subnets 
    tags = {
        Environment = var.env
    }
}

resource "aws_lb_listener" "http" {
    count             = var.create_alb ? 1 : 0
    load_balancer_arn = aws_lb.alb[0].arn
    port              = "80"
    protocol          = "HTTP"
    default_action {
        type             = "forward"
        target_group_arn = var.target_group 
    }
}

resource "aws_lb_listener" "https" {
    count             = (var.create_alb && var.enable_https) ? 1 : 0
    load_balancer_arn = aws_lb.alb[0].arn
    port              = "443"
    protocol          = "HTTPS"
    default_action {
        type             = "forward"
        target_group_arn = var.target_group 
    }
}

resource "aws_lb_target_group" "alb_tg" {
    count       = var.create_target_group == true ? 1 : 0
    name        = "${var.project_id}-${var.env}-lb-tg"
    port        = var.port 
    protocol    = var.protocol 
    target_type = var.target_type 
    vpc_id      = var.vpc_id 
}
