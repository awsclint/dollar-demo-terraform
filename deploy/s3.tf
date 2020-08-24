resource "aws_s3_bucket" "webapp" {
  bucket = "${var.webapp}-artifact"
  acl    = "private"

  tags               = {
    Terraform   = "true"
    Environment = "dev"
    Owner       = "cliwhite"
  }
}