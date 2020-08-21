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

