  
terraform {
  backend "s3" {
    bucket = "awsclint-tfstate"
    key    = "dollars-demo/webapp"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.aws_region
}

provider "aws" {
  alias  = "west"
  region = "us-west-2"
}
