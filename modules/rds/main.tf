locals {
  username = var.username != null ? var.username : (length(random_string.username) > 0 ? random_string.username[0].result : null)
  password = var.password != null ? var.password : (length(random_password.password) > 0 ? random_password.password[0].result : null)
}

resource "random_string" "username" {
  count   = var.username == null ? 1 : 0
  length  = 8
  special = false
  numeric = false # Garante que comece com letra para evitar problemas em algumas engines
}

resource "random_password" "password" {
  count            = var.password == null ? 1 : 0
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_db_subnet_group" "this" {
  name        = "${var.identifier}-subnet-group"
  description = "Subnet group para o RDS ${var.identifier}"
  subnet_ids  = var.subnet_ids

  tags = merge(var.tags, {
    Name = "${var.identifier}-subnet-group"
  })
}

resource "aws_db_parameter_group" "this" {
  count = var.parameter_group_family != null ? 1 : 0

  name   = "${var.identifier}-params"
  family = var.parameter_group_family

  dynamic "parameter" {
    for_each = var.parameters
    content {
      name  = parameter.value.name
      value = parameter.value.value
    }
  }

  tags = var.tags
}

resource "aws_db_instance" "this" {
  identifier = var.identifier

  engine         = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class

  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = var.storage_type
  storage_encrypted     = var.storage_encrypted
  kms_key_id            = var.kms_key_id

  db_name  = var.db_name
  username = local.username
  password = local.password
  port     = var.port

  multi_az               = var.multi_az
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = var.vpc_security_group_ids
  publicly_accessible    = var.publicly_accessible

  parameter_group_name = var.parameter_group_family != null ? aws_db_parameter_group.this[0].name : null

  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window
  maintenance_window      = var.maintenance_window

  performance_insights_enabled = var.performance_insights_enabled
  monitoring_interval          = var.monitoring_interval
  monitoring_role_arn          = var.monitoring_role_arn

  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  deletion_protection = var.deletion_protection
  skip_final_snapshot = var.skip_final_snapshot

  tags = var.tags
}

resource "aws_secretsmanager_secret" "this" {
  name = "${coalesce(var.db_name, var.identifier)}-db-conn-string"
  tags = var.tags
}

resource "aws_secretsmanager_secret_version" "this" {
  secret_id = aws_secretsmanager_secret.this.id
  secret_string = jsonencode({
    username = local.username
    password = local.password
    engine   = var.engine
    host     = aws_db_instance.this.address
    port     = aws_db_instance.this.port
    db_name  = var.db_name
    endpoint = aws_db_instance.this.endpoint
  })
}
