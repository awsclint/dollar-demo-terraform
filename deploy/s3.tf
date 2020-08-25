resource "aws_s3_bucket" "webapp" {
  bucket = "${var.webapp}-artifact"
  acl    = "private"

  tags               = {
    Terraform   = "true"
    Environment = "dev"
    Owner       = "cliwhite"
  }
}

resource "aws_s3_bucket" "webapp-west" {
  bucket = "${var.webapp}-artifacts-west"
  acl    = "private"
  provider = aws.west

  tags               = {
    Terraform   = "true"
    Environment = "dev"
    Owner       = "cliwhite"
  }
}
