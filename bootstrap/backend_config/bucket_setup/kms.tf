module "kms" {
  source = "terraform-aws-modules/kms/aws"

  description = "encryption for tfstate"
  key_usage   = "ENCRYPT_DECRYPT"

  enable_default_policy = true

  aliases = ["tfstate"]

  enable_key_rotation     = true
  deletion_window_in_days = 30

}
