## Elastic Container Registry ##

resource "aws_ecr_repository" "docker_ecr" {
  name                 = "docker-repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

data "aws_iam_policy_document" "ecr_repo_policy_document" {
  statement {
    sid    = "ecr_policy"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["545960039078"]
    }

    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:DescribeRepositories",
      "ecr:GetRepositoryPolicy",
      "ecr:ListImages",
      "ecr:DeleteRepository",
      "ecr:BatchDeleteImage",
      "ecr:SetRepositoryPolicy",
      "ecr:DeleteRepositoryPolicy",
    ]
  }
}

resource "aws_ecr_repository_policy" "ecr_repo_policy" {
  repository = aws_ecr_repository.docker_ecr.name
  policy     = data.aws_iam_policy_document.ecr_repo_policy_document.json
}