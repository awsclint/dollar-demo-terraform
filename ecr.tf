resource "aws_ecr_repository" "web" {
  name                 = "dollars-demo-web"
  image_tag_mutability = "MUTABLE"
  encryption_configuration {
      encryption_type      = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "app" {
  name                 = "dollars-demo-app"
  image_tag_mutability = "MUTABLE"
  encryption_configuration {
      encryption_type      = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
}