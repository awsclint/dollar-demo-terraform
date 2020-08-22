resource "aws_ecs_cluster" "east" {
  name = "dollar-demo-cluster-east"
  capacity_providers = ["FARGATE"]
  tags               = {
    Terraform   = "true"
    Environment = "dev"
    Owner       = "cliwhite"
  }
}

resource "aws_ecs_cluster" "west" {
  provider = aws.west
  name = "dollar-demo-cluster-west"
  capacity_providers = ["FARGATE"]
  tags               = {
    Terraform   = "true"
    Environment = "dev"
    Owner       = "cliwhite"
  }
}

resource "aws_ecs_task_definition" "webapp-east" {
    family = var.webapp
    container_definitions = file("task-definitions/webapp.json")
    network_mode             = "awsvpc"

    requires_compatibilities = ["FARGATE"]
    cpu                      = 256
    memory                   = 512
    execution_role_arn       = aws_iam_role.fargate_execution_role.arn

}

resource "aws_ecs_service" "webapp-east" {
    name = var.webapp
    cluster = aws_ecs_cluster.east.id
    task_definition = aws_ecs_task_definition.webapp-east.arn
    desired_count = 3
    launch_type = "FARGATE"
    
    network_configuration {
      subnets = ["subnet-03e2fbcd549a5d6a0", "subnet-0c99cdabe86a4d948", "subnet-0f6754f32fb0dd8f9"]
      security_groups = [aws_security_group.webapp-east-fargate.id]
    }
    depends_on = [aws_iam_role_policy.ecs_service_role_policy]

    load_balancer {
        target_group_arn = aws_lb_target_group.webapp-east.arn
        container_name = var.webapp
        container_port = 80
    }
}

resource "aws_iam_role" "ecs_service_role" {
    name = "ecs_service_role"
    assume_role_policy = file("policies/ecs-role.json")
}

resource "aws_iam_role_policy" "ecs_service_role_policy" {
    name = "ecs_service_role_policy"
    policy = file("policies/ecs-service-role-policy.json")
    role = aws_iam_role.ecs_service_role.id
}

resource "aws_iam_role" "fargate_execution_role" {
    name = "fargate_execution_role"
    assume_role_policy = file("policies/fargate-execution-role.json")
}

resource "aws_iam_role_policy" "fargate_execution_role_policy" {
    name = "fargate_execution_role_policy"
    policy = file("policies/fargate-execution-role-policy.json")
    role = aws_iam_role.fargate_execution_role.id
}
resource "aws_security_group" "webapp-east-fargate" {
  name        = "${var.webapp}-fargate"
  description = "Allow traffic from ALB SG"
  vpc_id      = var.vpc_east

    ingress {
    description = "80 from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.webapp-east.id]
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