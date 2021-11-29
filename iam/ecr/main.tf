locals {
    namespace = "${var.project_id}-${var.env}"
}

resource "aws_iam_user" "ci_user" {
    count = var.create_ci_user == true ? 1 : 0
    name  = "ci-${local.namespace}-server-user"
}

resource "aws_iam_access_key" "ci_key" {
    count = var.create_ci_user == true ? 1 : 0
    user  = aws_iam_user.ci_user[0].name
}

data "aws_iam_policy_document" "ci_server_access" {
    version = "2012-10-17"
    statement {
        actions = [
            "ecr:BatchCheckLayerAvailability",
            "ecr:GetDownloadUrlForLayer",
            "ecr:GetRepositoryPolicy",
            "ecr:DescribeRepositories",
            "ecr:ListImages",
            "ecr:DescribeImages",
            "ecr:BatchGetImage",
            "ecr:GetLifecyclePolicy",
            "ecr:GetLifecyclePolicyPreview",
            "ecr:ListTagsForResource",
            "ecr:DescribeImageScanFindings",
            "ecr:InitiateLayerUpload",
            "ecr:UploadLayerPart",
            "ecr:CompleteLayerUpload",
            "ecr:PutImage"
        ]
        effect = "Allow"
        resources = var.ecr_resource_arns
    }
    statement {
        actions = [
            "ecr:CreateRepository",
            "ecr:GetAuthorizationToken"
        ]
        effect = "Allow"
        resources = [
            "*"
        ]
    }
    statement {
        actions = [
            "ecs:UpdateService",
            "ecs:DescribeServices",
            "ecs:RegisterTaskDefinition"
        ]
        effect = "Allow"
        resources = [
            "*"
        ]
    }

    statement {
        actions = [
            "iam:PassRole"
        ]
        effect = "Allow"
        resources = [
            "*"
        ]
    }

    ## Extend with iam permission statements
    dynamic "statement" {
        for_each = var.other_iam_statements != null ? var.other_iam_statements : {}
        content {
            actions   = statement.value["actions"]
            effect    = statement.value["effect"]
            resources = statement.value["resources"]
        }
    }
}

resource "aws_iam_user_policy" "ci_user_policy" {
    name   = "ci-${local.namespace}-user-policy"
    user   = aws_iam_user.ci_user[0].name
    policy = data.aws_iam_policy_document.ci_server_access.json
}
