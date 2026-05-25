terraform {
  source = "../../modules/rds"
}

inputs = {
  identifier = "dev-db-mysql"

  engine         = "mysql"
  engine_version = "8.0.35"
  instance_class = "db.t3.micro"
  port           = 3306

  allocated_storage = 20
  storage_type      = "gp3"

  db_name  = "devdb"

  multi_az = false

  subnet_ids             = ["subnet-789", "subnet-012"]
  vpc_security_group_ids = ["sg-345"]

  skip_final_snapshot = true

  tags = {
    Environment = "dev"
    Project     = "internal-tools"
  }
}
