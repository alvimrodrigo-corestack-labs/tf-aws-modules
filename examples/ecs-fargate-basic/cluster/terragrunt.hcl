terraform {
  source = "../../../modules/ecs-cluster"
}

inputs = {
  name = "production-cluster"
  
  tags = {
    Environment = "prod"
    Project     = "core-infra"
  }
}
