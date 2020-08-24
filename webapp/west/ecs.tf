resource "aws_ecs_cluster" "west" {
  name = "dollar-demo-cluster-west"
  capacity_providers = ["FARGATE"]
  tags               = {
    Terraform   = "true"
    Environment = "dev"
    Owner       = "cliwhite"
  }
}

resource "aws_ecs_task_definition" "webapp-west" {
    family = var.webapp
    container_definitions = file("task-definitions/webapp.json")
    network_mode             = "awsvpc"

    requires_compatibilities = ["FARGATE"]
    cpu                      = 256
    memory                   = 512
    execution_role_arn       = var.fargate_execution_role

}

resource "aws_ecs_service" "webapp-west" {
    name = var.webapp
    cluster = aws_ecs_cluster.west.id
    task_definition = aws_ecs_task_definition.webapp-west.arn
    desired_count = 3
    launch_type = "FARGATE"
    
    network_configuration {
      subnets = var.priv_subnets
      security_groups = [aws_security_group.webapp-west-fargate.id]
    }

    load_balancer {
        target_group_arn = aws_lb_target_group.webapp-west.arn
        container_name = var.webapp
        container_port = 80
    }
}

resource "aws_security_group" "webapp-west-fargate" {
  name        = "${var.webapp}-fargate"
  description = "Allow traffic from ALB SG"
  vpc_id      = var.vpc_west

    ingress {
    description = "80 from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.webapp-west.id]
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