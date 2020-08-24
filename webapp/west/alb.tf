#WebApp ALB in US-WEST-2
resource "aws_lb" "webapp-west" {
  name               = var.webapp
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.webapp-west.id]
  subnets            = var.pub_subnets

  tags               = {
    Terraform   = "true"
    Environment = "dev"
    Owner       = "cliwhite"
  }
}

#ACM Cert was previously created
resource "aws_lb_listener" "webapp-west-https" {
  load_balancer_arn = aws_lb.webapp-west.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.cert_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.webapp-west.arn
  }
}

resource "aws_lb_listener" "webapp-west-http" {
  load_balancer_arn = aws_lb.webapp-west.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_target_group" "webapp-west" {
  name     = var.webapp
  port     = 80
  protocol = "HTTP"
  target_type = "ip"
  vpc_id   = var.vpc_west
}

resource "aws_security_group" "webapp-west" {
  name        = var.webapp
  description = "Allow inbound web traffic from anywhere"
  vpc_id      = var.vpc_west

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
    description = "80 from VPC"
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

  tags               = {
    Terraform   = "true"
    Environment = "dev"
    Owner       = "cliwhite"
  }
}

resource "aws_route53_record" "webapp" {
  zone_id = "Z05314583A02UE0WUMG81"
  name    = "west.demo.awsclint.com"
  type    = "A"

  alias {
    name                   = aws_lb.webapp-west.dns_name
    zone_id                = aws_lb.webapp-west.zone_id
    evaluate_target_health = true
  }
}