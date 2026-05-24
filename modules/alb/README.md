# Módulo AWS Application Load Balancer (ALB)

Módulo production-grade para provisionamento de ALBs suportando múltiplos cenários (EC2, ASG, ECS).

## Recursos Suportados

- Suporte a HTTP e HTTPS (ACM).
- Redirect automático HTTP -> HTTPS.
- Múltiplos Target Groups (Instance ou IP).
- Suporte a ECS Fargate (Target Type: IP).
- Integração com WAFv2.
- Access Logs no S3.
- Stickiness e Health Checks customizados.

## Exemplos

### 1. EC2 Basic (HTTP -> HTTPS Redirect)
Localizado em `examples/alb-ec2-basic/`. Este exemplo mostra como configurar um ALB que redireciona tráfego inseguro e aponta para instâncias EC2.

### 2. ECS Fargate
Localizado em `examples/alb-ecs-fargate/`. Configuração otimizada para microserviços rodando em Fargate, utilizando `target_type = "ip"`.
