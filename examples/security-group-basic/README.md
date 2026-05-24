# Exemplo: Security Group Basic

Este exemplo demonstra como utilizar o módulo `security-group` para criar um Security Group com regras dinâmicas de entrada e saída.

## Características do Exemplo

- **Criação de SG**: Cria um SG chamado `web-server-sg`.
- **Regras de Ingress**:
  - Porta 80 (HTTP) liberada para o mundo (CIDR).
  - Porta 443 (HTTPS) liberada para o mundo (CIDR).
  - Porta 22 (SSH) liberada apenas para um Security Group específico (Referência de SG).
- **Regras de Egress**:
  - Liberação total de saída (`-1` protocol).

## Como usar

Certifique-se de alterar o `vpc_id` e o ID do `security_groups` no arquivo `terragrunt.hcl` para valores válidos em sua conta AWS.

```hcl
inputs = {
  vpc_id = "vpc-xxxxxx"
  # ...
}
```
