# ECS Decoupled Modules

Este conjunto de módulos permite provisionar Clusters e Serviços ECS de forma independente e escalável.

## Módulos

### 1. `ecs-cluster`
Gerencia a infraestrutura base do cluster, incluindo Container Insights e Capacity Providers (Fargate/Spot).

### 2. `ecs-service`
Gerencia a definição da tarefa (Task Definition), o serviço ECS, roles de execução, CloudWatch Logs e integração com ALB.

## Exemplo de Integração (Terragrunt)

Veja a pasta `examples/ecs-fargate-basic/` para um exemplo de como encadear a criação do cluster e do serviço utilizando dependências do Terragrunt.
