variable "environment" {
  type        = string
  description = "The environment in which resources are built"
}

variable "github_login" {
  type        = string
  description = "Your Github username. It is case sensitive. All OIDC details can be found at https://api.github.com/repos/<username>/<repository>"
}

variable "github_ID" {
  type        = string
  description = "Your Github ID. All OIDC details can be found at https://api.github.com/repos/<username>/<repository>"
}

variable "repository_name" {
  type        = string
  description = "Your repository name. It can be left as stripExif unless you have changed it. All OIDC details can be found at https://api.github.com/repos/<username>/<repository>"
default = "stripExif"
}

variable "repository_ID" {
  type        = string
  description = "Your repository ID. All OIDC details can be found at https://api.github.com/repos/<username>/<repository>"
}