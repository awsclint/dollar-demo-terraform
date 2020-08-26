resource "aws_ecr_repository" "web" {
  name                 = var.webapp
  image_tag_mutability = "MUTABLE"
  encryption_configuration {
      encryption_type      = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  tags               = {
    Terraform   = "true"
    Environment = "dev"
    Owner       = "cliwhite"
  }
}