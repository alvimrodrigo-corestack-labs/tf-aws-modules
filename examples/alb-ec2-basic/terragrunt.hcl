terraform {
  source = "../../modules/alb"
}

inputs = {
  name           = "ec2-app-alb"
  vpc_id         = "vpc-12345678"
  subnets        = ["subnet-111111", "subnet-222222"]
  security_groups = ["sg-web-alb"]

  http_tcp_listeners = [
    {
      port        = 80
      protocol    = "HTTP"
      default_action = {
        type = "redirect"
        redirect = {
          port        = "443"
          protocol    = "HTTPS"
          status_code = "HTTP_301"
        }
      }
    }
  ]

  https_listeners = [
    {
      port            = 443
      protocol        = "HTTPS"
      certificate_arn = "arn:aws:acm:us-east-1:123456789012:certificate/xxxx-xxxx"
      default_action = {
        type              = "forward"
        target_group_name = "tg-app-v1"
      }
    }
  ]

  target_groups = [
    {
      name        = "tg-app-v1"
      port        = 80
      protocol    = "HTTP"
      target_type = "instance"
      health_check = {
        path    = "/health"
        matcher = "200"
      }
    }
  ]

  tags = {
    Environment = "prod"
    Owner       = "devops"
  }
}
