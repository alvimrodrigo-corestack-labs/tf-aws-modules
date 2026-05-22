# VPC Terraform Module

## Descrição
Este módulo gerencia a infraestrutura de rede básica (VPC) na AWS, incluindo subnets públicas e privadas, Internet Gateway e NAT Gateways configuráveis. É ideal para ambientes de laboratório ou portfólio devido à sua flexibilidade de custos.

## Arquitetura
O módulo cria:
- 1 VPC com DNS Hostnames/Support habilitados.
- N Subnets Públicas (uma por AZ fornecida).
- N Subnets Privadas (uma por AZ fornecida).
- 1 Internet Gateway.
- NAT Gateways condicionais (opcionalmente apenas 1 para economizar custos).

## Exemplo de Uso (Terragrunt)
```hcl
terraform {
  source = "../../modules/vpc"
}

inputs = {
  name               = "meu-lab-vpc"
  cidr_block         = "10.0.0.0/16"
  availability_zones = ["us-east-1a", "us-east-1b"]
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets    = ["10.0.10.0/24", "10.0.11.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true # Recomendado para Labs

  tags = {
    Environment = "Dev"
    Project     = "Portfolio"
  }
}
```

## Inputs
| Nome | Descrição | Tipo | Padrão | Obrigatório |
|------|-----------|------|---------|:-----------:|
| name | Nome base para os recursos | string | - | sim |
| cidr_block | Bloco CIDR da VPC | string | - | sim |
| availability_zones | Lista de AZs | list(string) | - | sim |
| public_subnets | CIDRs das subnets públicas | list(string) | [] | não |
| private_subnets | CIDRs das subnets privadas | list(string) | [] | não |
| enable_nat_gateway | Habilita NAT Gateway | bool | false | não |
| single_nat_gateway | Um único NAT para todas as AZs | bool | true | não |
| tags | Tags adicionais | map(string) | {} | não |

## Outputs
| Nome | Descrição |
|------|-----------|
| vpc_id | ID da VPC criada |
| vpc_cidr_block | CIDR da VPC |
| public_subnet_ids | IDs das subnets públicas |
| private_subnet_ids | IDs das subnets privadas |
| nat_public_ips | IPs públicos dos NAT Gateways |
