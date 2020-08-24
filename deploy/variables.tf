variable "aws_region" {
  default     = "us-east-1"
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
  default = "dollars-demo-app"
}

variable "branch" {
  type = string
  default = "master"
}