terraform {
  source = "../../modules/rds"
}

inputs = {
  identifier = "production-db-postgres"

  engine         = "postgres"
  engine_version = "15.4"
  instance_class = "db.t3.medium"
  port           = 5432

  allocated_storage     = 50
  max_allocated_storage = 200 # Habilita autoscaling de storage
  storage_type          = "gp3"

  db_name  = "myappdb"

  multi_az = true

  subnet_ids             = ["subnet-123", "subnet-456"]
  vpc_security_group_ids = ["sg-789"]

  parameter_group_family = "postgres15"
  parameters = [
    {
      name  = "log_connections"
      value = "1"
    }
  ]

  performance_insights_enabled = true
  monitoring_interval          = 60 # Enhanced Monitoring

  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]

  tags = {
    Environment = "prod"
    Project     = "ecommerce"
  }
}
