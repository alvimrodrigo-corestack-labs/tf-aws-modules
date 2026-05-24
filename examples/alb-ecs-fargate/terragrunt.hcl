terraform {
  source = "../../modules/alb"
}

inputs = {
  name           = "ecs-fargate-alb"
  vpc_id         = "vpc-12345678"
  subnets        = ["subnet-111111", "subnet-222222"]
  security_groups = ["sg-ecs-alb"]

  http_tcp_listeners = [
    {
      port     = 80
      protocol = "HTTP"
      default_action = {
        type              = "forward"
        target_group_name = "tg-fargate-api"
      }
    }
  ]

  target_groups = [
    {
      name        = "tg-fargate-api"
      port        = 8080
      protocol    = "HTTP"
      target_type = "ip" # Obrigatorio para Fargate
      health_check = {
        path    = "/api/v1/status"
        interval = 15
      }
    }
  ]

  tags = {
    Service = "api-fargate"
    ManagedBy = "Terraform"
  }
}
