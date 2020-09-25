variable "aws_region_east" {
  default     = "us-east-1"
}

variable "aws_region_west" {
  default     = "us-west-2"
}

variable "primary_zone_id" {
  type = string
  default = "Z05314583A02UE0WUMG81"
}

variable "tld_domain" {
  type = string
  default = "demo.awsclint.com"
}

variable "tld_api_domain" {
  type = string
  default = "api.awsclint.com"
}

variable "east_domain" {
  type = string
  default = "east.demo.awsclint.com"
}

variable "east_api_domain" {
  type = string
  default = "api-east.demo.awsclint.com"
}

variable "west_domain" {
  type = string
  default = "west.demo.awsclint.com"
}

variable "west_api_domain" {
  type = string
  default = "api-west.demo.awsclint.com"
}

variable "east_webapp_alb_dns" {
  type = string
  default = "dollars-demo-web-1093370162.us-east-1.elb.amazonaws.com"
}

variable "east_api_alb_dns" {
  type = string
  default = "dollars-demo-api-1066087086.us-east-1.elb.amazonaws.com"
}

variable "east_webapp_alb_zone_id" {
  type = string
  default = "Z35SXDOTRQ7X7K"
  description = "ALB Hosted Zone ID"
}

variable "east_api_alb_zone_id" {
  type = string
  default = "Z35SXDOTRQ7X7K"
  description = "ALB Hosted Zone ID"
}

variable "west_webapp_alb_dns" {
  type = string
  default = "dollars-demo-web-379814584.us-west-2.elb.amazonaws.com"
}

variable "west_api_alb_dns" {
  type = string
  default = "dollars-demo-api-1546545589.us-west-2.elb.amazonaws.com"
}

variable "west_webapp_alb_zone_id" {
  type = string
  default = "Z1H1FL5HABSF5"
  description = "ALB Hosted Zone ID"
}

variable "west_api_alb_zone_id" {
  type = string
  default = "Z1H1FL5HABSF5"
  description = "ALB Hosted Zone ID"
}