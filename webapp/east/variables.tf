variable "aws_region" {
  default     = "us-east-1"
}

variable "webapp" {
    type        = string
    description = "Name of Web App"
    default     = "dollars-demo-web"
}

variable "api" {
    type        = string
    description = "Name of Web App"
    default     = "dollars-demo-api"
}

variable "vpc_east" {
    type        = string
    default     = "vpc-03fd0689b99085481"
}

variable "priv_subnets" {
    type = list
    default = ["subnet-03e2fbcd549a5d6a0", "subnet-0c99cdabe86a4d948", "subnet-0f6754f32fb0dd8f9"]
}

variable "pub_subnets" {
    type = list
    default = ["subnet-0f5b64ed0463e03f0","subnet-04e1a05b10dd31548", "subnet-07b2b1c96683143c6"]
}

variable "cert_arn" {
    type = string
    default = "arn:aws:acm:us-east-1:251607623447:certificate/4252177a-6ceb-4d71-b40b-312e36eed95d"
}
variable "fargate_execution_role" {
    type = string
    default = "arn:aws:iam::251607623447:role/fargate_execution_role"
}

variable "ecs_cluster" {
  type = string
  default = "dollar-demo-cluster-east"
}