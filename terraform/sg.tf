resource "aws_security_group" "strapi_ec2_sg" {
  name        = "strapi-ec2-sg"
  description = "Allow 1337 from ALB"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 1337
    to_port     = 1337
    protocol    = "tcp"
    security_groups = [aws_security_group.strapi_alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "strapi_alb_sg" {
  name        = "strapi-alb-sg"
  description = "Allow HTTP from public"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

