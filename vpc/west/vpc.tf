
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"

  name               = "dollars-demo-west"
  cidr               = "10.10.0.0/16"
  azs                = ["us-west-2a", "us-west-2b", "us-west-2c"]
  private_subnets    = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
  public_subnets     = ["10.10.101.0/24", "10.10.102.0/24", "10.10.103.0/24"]
  enable_nat_gateway = true
  single_nat_gateway = true
  tags               = {
    Terraform   = "true"
    Environment = "dev"
    Owner       = "cliwhite"
  }
}