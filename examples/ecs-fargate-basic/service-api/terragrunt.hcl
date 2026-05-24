terraform {
  source = "../../../modules/ecs-service"
}

dependency "cluster" {
  config_path = "../cluster"
}

# Supondo que você tenha um ALB já configurado (referência ao modulo alb anterior)
# dependency "alb" {
#   config_path = "../../alb-ecs-fargate"
# }

inputs = {
  name        = "api-backend"
  cluster_arn = dependency.cluster.outputs.cluster_arn
  
  cpu    = 256
  memory = 512
  
  subnets         = ["subnet-11111", "subnet-22222"]
  security_groups = ["sg-service-123"]
  
  # target_group_arn = dependency.alb.outputs.target_group_arns["tg-fargate-api"]
  # container_name   = "app"
  # container_port   = 8080

  container_definitions = jsonencode([
    {
      name      = "app"
      image     = "nginx:latest"
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/api-backend"
          "awslogs-region"        = "us-east-1"
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])

  tags = {
    Service = "api"
  }
}
