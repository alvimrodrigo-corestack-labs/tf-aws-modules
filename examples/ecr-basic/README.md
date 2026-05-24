# Exemplo: ECR Basic

Este exemplo demonstra a criação de um repositório ECR com política de ciclo de vida para gerenciar a retenção de imagens.

## Uso

```hcl
inputs = {
  name = "lab-app-repo"

  lifecycle_policy = jsonencode({
    rules = [{
      rulePriority = 1
      description  = "Expire old images"
      selection = {
        tagStatus     = "any"
        countType     = "imageCountMoreThan"
        countNumber   = 5
      }
      action = {
        type = "expire"
      }
    }]
  })

  tags = {
    Environment = "Lab"
  }
}
```
