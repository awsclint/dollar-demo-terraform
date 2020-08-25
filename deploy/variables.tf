variable "aws_region_east" {
  default     = "us-east-1"
}

variable "aws_region_west" {
  default     = "us-west-2"
}

variable "webapp" {
    type        = string
    description = "Name of Web App"
    default     = "dollars-demo-web"
}

variable "owner" {
  type = string
  default = "awsclint"
}

variable "repo" {
  type = string
  default = "dollars-demo-web"
}

variable "branch" {
  type = string
  default = "master"
}

variable "ecs_cluster" {
  type = string
  default = "dollar-demo-cluster"
}