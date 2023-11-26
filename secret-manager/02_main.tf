# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret
module "secrets" {
  source = "../01-modules/secret"

  environment = var.environment
  nickname    = var.nickname
  tags        = var.tags

  secret_specs = {
    database_password = {
      description   = "A sample secure. e.g password"
      secret_string = var.database_password
    }
  }
}
