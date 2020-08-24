variable "aws_region" {
  default     = "us-west-2"
}

variable "webapp" {
    type        = string
    description = "type of Web App"
    default     = "dollars-demo-web"
}

variable "api" {
    type        = string
    description = "type of Web App"
    default     = "dollars-demo-api"
}


variable "vpc_west" {
    type        = string
    default     = "vpc-07e4d57ff88c2cb70"
}

variable "priv_subnets" {
    type = list
    default = ["subnet-00be813af0f62cf39","subnet-026ac40232d745fa1","subnet-0e59224ed27e5837a"]
}

variable "pub_subnets" {
    type = list
    default = ["subnet-09cf4e2625ab327e1","subnet-0bb3b104dffaa2f32","subnet-0c6a97e56f3c7a9e8"]
}

variable "cert_arn" {
    type = string
    default = "arn:aws:acm:us-west-2:251607623447:certificate/41653317-a845-4a1f-9774-4cab2d3d8c68"
}

variable "fargate_execution_role" {
    type = string
    default = "arn:aws:iam::251607623447:role/fargate_execution_role"
}
