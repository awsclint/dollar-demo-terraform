resource "aws_ecs_task_definition" "api-east" {
    family = var.api
    container_definitions = file("task-definitions/api.json")
    network_mode             = "awsvpc"

    requires_compatibilities = ["FARGATE"]
    cpu                      = 256
    memory                   = 512
    execution_role_arn       = var.fargate_execution_role

}

resource "aws_ecs_service" "api-east" {
    name = var.api
    cluster = var.ecs_cluster_arn
    task_definition = aws_ecs_task_definition.api-east.arn
    desired_count = 3
    launch_type = "FARGATE"

    lifecycle {
    ignore_changes = [desired_count,task_definition]
     }
    
    network_configuration {
      subnets = var.priv_subnets
      security_groups = [aws_security_group.api-east-fargate.id]
    }

    load_balancer {
        target_group_arn = aws_lb_target_group.api-east.arn
        container_name = var.api
        container_port = 5050
    }
}

resource "aws_security_group" "api-east-fargate" {
  name        = "${var.api}-fargate"
  description = "Allow traffic from ALB SG"
  vpc_id      = var.vpc_east

    ingress {
    description = "5050 from VPC"
    from_port   = 5050
    to_port     = 5050
    protocol    = "tcp"
    security_groups = [aws_security_group.api-east.id]
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