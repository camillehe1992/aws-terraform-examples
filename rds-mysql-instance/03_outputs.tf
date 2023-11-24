output "aws_db_instance" {
  value = {
    arn      = aws_db_instance.this.arn
    endpoint = aws_db_instance.this.endpoint
    address  = aws_db_instance.this.address
  }
}

output "secret_arn" {
  value = aws_db_instance.this.master_user_secret[0].secret_arn
}

output "function_arn" {
  value = module.interact_database_func.function.arn
}
