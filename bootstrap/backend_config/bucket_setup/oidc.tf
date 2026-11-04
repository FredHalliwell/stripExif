module "github-oidc" {
  source  = "terraform-module/github-oidc-provider/aws"
  version = "~> 1"

  create_oidc_provider = true
  create_oidc_role     = true

  repositories = ["${var.github_login}@${var.github_ID}/${var.repository_name}@${var.repository_ID}"]
    oidc_role_attach_policies = [
    aws_iam_policy.tfstate_access.arn
  ]
}