data "aws_security_group" "default" {
  name   = "default"
  vpc_id = module.vpc.vpc_id
}
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"

  name               = "dollars-demo-west"
  cidr               = "10.10.0.0/16"
  azs                = ["us-west-2a", "us-west-2b", "us-west-2c"]
  private_subnets    = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
  public_subnets     = ["10.10.101.0/24", "10.10.102.0/24", "10.10.103.0/24"]
  database_subnets    = ["10.10.201.0/24", "10.10.202.0/24", "10.10.203.0/24"]
  enable_nat_gateway = true
  single_nat_gateway = true
  enable_s3_endpoint = true
  create_database_subnet_group = true
  tags               = {
    Terraform   = "true"
    Environment = "dev"
    Owner       = "cliwhite"
  }
}