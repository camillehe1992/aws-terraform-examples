module "secrets" {
  source = "./modules/secretsmanager"

  env      = var.env
  nickname = var.nickname
  tags     = var.tags

  secret_specs = {
    database_password = {
      description   = "A sample secure. e.g password"
      secret_string = var.database_password
    }
  }
}
