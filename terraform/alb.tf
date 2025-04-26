resource "aws_lb" "strapi_alb" {
  name               = "strapi-alb-new"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.public_subnet_ids
  security_groups    = [aws_security_group.strapi_alb_sg.id]
}

resource "aws_lb_target_group" "strapi_tg" {
  name     = "strapi-tg-new"
  port     = 1337
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    port                = "1337"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group_attachment" "strapi_attachment" {
  target_group_arn = aws_lb_target_group.strapi_tg.arn
  target_id        = aws_instance.strapi.id
  port             = 1337
}

resource "aws_lb_listener" "strapi_listener" {
  load_balancer_arn = aws_lb.strapi_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.strapi_tg.arn
  }
}

