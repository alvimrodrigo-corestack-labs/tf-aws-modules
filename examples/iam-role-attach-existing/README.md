# Exemplo: Anexar Políticas a uma Role Existente

Este exemplo demonstra como usar o módulo `iam-role` para anexar novas políticas (gerenciadas ou inline) a uma IAM Role que já existe na AWS e não é gerenciada por este código (ou é gerenciada em outro lugar).

## Uso

```hcl
inputs = {
  create_role = false
  role_name   = "my-pre-existing-role" # Nome da role já existente na AWS

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
  ]

  inline_policies = {
    "DynamoDBReadOnly" = jsonencode({
      Version = "2012-10-17"
      Statement = [{
        Action   = "dynamodb:GetItem"
        Effect   = "Allow"
        Resource = "*"
      }]
    })
  }
}
```
