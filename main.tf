module "stripExif" {
  source = "./modules/stripExif"

  environment = var.environment
}

module "users" {
  source = "./modules/users"

  environment = var.environment
}