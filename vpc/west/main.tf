terraform {
    backend "s3" {
    bucket = "awsclint-tfstate"
    key    = "dollars-demo/west/vpc"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-west-2"
}