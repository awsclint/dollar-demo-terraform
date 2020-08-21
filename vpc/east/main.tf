terraform {
  backend "s3" {
    bucket = "awsclint-tfstate"
    key    = "dollars-demo/east/vpc"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}