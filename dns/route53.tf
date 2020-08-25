#Top Level Domain
resource "aws_route53_record" "tld-east" {
  zone_id = var.primary_zone_id
  name    = var.tld_domain
  type    = "CNAME"
  records = [var.east_domain]
  health_check_id = aws_route53_health_check.east.id
  set_identifier  = "tld-east"
  ttl     =  60
  latency_routing_policy {
    region = var.aws_region_east
  }
}

resource "aws_route53_record" "tld-west" {
  zone_id = var.primary_zone_id
  name    = var.tld_domain
  type    = "CNAME"
  records = [var.west_domain]
  health_check_id = aws_route53_health_check.west.id
  set_identifier  = "tld-west"
  ttl     =  60
  latency_routing_policy {
    region = var.aws_region_west
  }
}

#EAST
resource "aws_route53_record" "webapp-east" {
  zone_id = var.primary_zone_id
  name    = var.east_domain
  type    = "A"

  alias {
    name                   = var.east_webapp_alb_dns
    zone_id                = var.east_webapp_alb_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_health_check" "east" {
  failure_threshold = "3"
  fqdn              = var.east_domain
  port              = 443
  request_interval  = "30"
  resource_path     = "/"
  search_string     = "Dollar$"
  type              = "HTTPS_STR_MATCH"
  measure_latency   = "true"
  tags = {
    Name = var.east_domain
  }
}

#WEST
resource "aws_route53_record" "webapp-west" {
  zone_id = var.primary_zone_id
  name    = var.west_domain
  type    = "A"
  
  alias {
    name                   = var.west_webapp_alb_dns
    zone_id                = var.west_webapp_alb_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_health_check" "west" {
  failure_threshold = "3"
  fqdn              = var.west_domain
  port              = 443
  request_interval  = "30"
  resource_path     = "/"
  search_string     = "Dollar$"
  type              = "HTTPS_STR_MATCH"
  measure_latency   = "true"
  tags = {
    Name = var.west_domain
  }
}