terraform {
  backend "s3" {
    bucket = "awsclint-tfstate"
    key    = "dollars-demo/dns"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.aws_region_east
}