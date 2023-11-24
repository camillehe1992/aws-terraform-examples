# https://registry.terraform.io/providers/hashicorp/aws/5.0.0/docs/resources/db_subnet_group
resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = var.subnet_ids

  tags = merge(var.tags,
    {
      Name = "${var.env}-${var.nickname}"
  })
}

# https://registry.terraform.io/providers/hashicorp/aws/5.0.0/docs/resources/db_instance
resource "aws_db_instance" "this" {
  identifier                  = var.identifier
  allocated_storage           = 50
  max_allocated_storage       = 100
  db_subnet_group_name        = aws_db_subnet_group.default.name
  engine                      = var.engine
  engine_version              = var.engine_version
  instance_class              = var.instance_class
  username                    = var.username
  manage_master_user_password = true
  publicly_accessible         = true
  parameter_group_name        = var.parameter_group_name
  vpc_security_group_ids      = var.vpc_security_group_ids
  skip_final_snapshot         = true

  tags = var.tags
}
