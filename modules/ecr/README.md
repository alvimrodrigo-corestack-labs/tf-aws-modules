# ECR Terraform Module

## Descrição
Este módulo cria um repositório Amazon ECR com suporte a criptografia, escaneamento de imagens e políticas de ciclo de vida.

## Arquitetura
O módulo utiliza:
- `aws_ecr_repository` para o repositório principal.
- `aws_ecr_lifecycle_policy` para gerenciamento opcional de expiração de imagens.
- Configurações de segurança (AES256/KMS) e conformidade (Scanning).

## Exemplo de Uso
```hcl
module "ecr" {
  source = "../../modules/ecr"

  name = "minha-app"
  
  lifecycle_policy = jsonencode({
    rules = [{
      rulePriority = 1
      description  = "Mantém apenas as últimas 10 imagens"
      selection = {
        tagStatus     = "any"
        countType     = "imageCountMoreThan"
        countNumber   = 10
      }
      action = {
        type = "expire"
      }
    }]
  })

  tags = {
    Environment = "Prod"
  }
}
```

## Inputs
| Nome | Descrição | Tipo | Padrão | Obrigatório |
|------|-----------|------|---------|:-----------:|
| name | Nome do repositório | string | - | sim |
| image_tag_mutability | Mutabilidade das tags | string | `IMMUTABLE` | não |
| scan_on_push | Escanear ao enviar | bool | `true` | não |
| encryption_type | Tipo de criptografia | string | `AES256` | não |
| kms_key | ARN da chave KMS | string | `null` | não |
| lifecycle_policy | JSON da política de ciclo de vida | string | `null` | não |
| tags | Tags adicionais | map(string) | `{}` | não |

## Outputs
| Nome | Descrição |
|------|-----------|
| repository_url | URL do repositório |
| repository_arn | ARN do repositório |
| repository_name | Nome do repositório |
| registry_id | ID do registro |
