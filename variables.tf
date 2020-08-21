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