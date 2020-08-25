data "aws_secretsmanager_secret_version" "github" {
  secret_id = "github"
}

locals {
  github  = jsondecode(data.aws_secretsmanager_secret_version.github.secret_string)["github"]
}

resource "aws_codepipeline" "codepipeline" {
  name     = var.webapp
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.webapp.bucket
    type     = "S3"
    region   = var.aws_region_east
  }

  artifact_store {
    location = aws_s3_bucket.webapp-west.bucket
    type     = "S3"
    region   = var.aws_region_west
  }


  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        Owner      = var.owner
        Repo       = var.repo
        Branch     = var.branch
        OAuthToken = local.github
      }
    }
  }
  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = var.webapp
      }
    }
  }
  stage {
    name = "Deploy_to_EAST"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ECS"
      region          = var.aws_region_east
      input_artifacts = ["build_output"]
      version         = "1"

      configuration = {
        ClusterName     = "${var.ecs_cluster}-east"
        ServiceName     = var.webapp
        FileName        = "imagedefinitions-east.json"
      }
    }
  }

  stage {
  name = "Approve"

  action {
    name     = "Approval"
    category = "Approval"
    owner    = "AWS"
    provider = "Manual"
    version  = "1"
    region   = var.aws_region_east
  }
}

    stage {
    name = "Deploy_to_WEST"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ECS"
      region          = var.aws_region_west
      input_artifacts = ["build_output"]
      version         = "1"

      configuration = {
        ClusterName     = "${var.ecs_cluster}-west"
        ServiceName     = var.webapp
        FileName        = "imagedefinitions-west.json"
      }
    }
  }
}

resource "aws_iam_role" "codepipeline_role" {
  name = "${var.webapp}-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name = "codepipeline_policy"
  role = aws_iam_role.codepipeline_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect":"Allow",
      "Action": [
        "s3:GetObject",
        "s3:GetObjectVersion",
        "s3:GetBucketVersioning",
        "s3:PutObject"
      ],
      "Resource": [
        "${aws_s3_bucket.webapp.arn}",
        "${aws_s3_bucket.webapp.arn}/*",
        "${aws_s3_bucket.webapp-west.arn}",
        "${aws_s3_bucket.webapp-west.arn}/*"
        ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "ecs:DescribeServices",
        "ecs:DescribeTaskDefinition",
        "ecs:DescribeTasks",
        "ecs:ListTasks",
        "ecs:RegisterTaskDefinition",
        "ecs:UpdateService",
        "codebuild:StartBuild",
        "codebuild:BatchGetBuilds",
        "iam:PassRole"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}