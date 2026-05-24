terraform {
  source = "../../modules/security-group"
}

inputs = {
  name        = "web-server-sg"
  description = "Security Group para servidores Web e acesso SSH"
  vpc_id      = "vpc-12345678" # Substituir pelo ID real da VPC

  ingress_rules = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "HTTP público"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "HTTPS público"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port       = 22
      to_port         = 22
      protocol        = "tcp"
      description     = "SSH apenas do Bastion"
      security_groups = ["sg-0a1b2c3d4e5f6g7h8"] # Exemplo de ID de SG
    }
  ]

  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "Permitir toda saída"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  tags = {
    Environment = "prod"
    Project     = "infra-core"
  }
}
