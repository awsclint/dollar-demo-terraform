variable "aws_region" {
  description = "AWS region to launch servers."
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

variable "vpc_west" {
    type        = string
    default     = "vpc-07e4d57ff88c2cb70"
}