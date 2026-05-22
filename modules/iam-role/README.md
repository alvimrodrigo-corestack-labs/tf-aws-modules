# IAM Role Terraform Module

## Descrição
Este módulo cria uma IAM Role na AWS de forma padronizada, permitindo configurar a política de confiança (Trust Relationship), anexar políticas gerenciadas e definir políticas inline.

## Arquitetura
O módulo utiliza:
- `aws_iam_role`: Criação do recurso principal com Trust Policy.
- `managed_policy_arns`: Atribuição direta de políticas gerenciadas.
- `aws_iam_role_policy`: Criação dinâmica de políticas inline via um mapa de entrada.

## Exemplo de Uso (IRSA - EKS)
```hcl
module "iam_role_irsa" {
  source = "../../modules/iam-role"

  role_name = "eks-pod-s3-access"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRoleWithWebIdentity"
      Effect = "Allow"
      Principal = {
        Federated = "arn:aws:iam::123456789012:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/EXAMPLE"
      }
      Condition = {
        StringEquals = {
          "oidc.eks.us-east-1.amazonaws.com/id/EXAMPLE:sub": "system:serviceaccount:default:my-app"
        }
      }
    }]
  })

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  ]
}
```

## Inputs
| Nome | Descrição | Tipo | Padrão | Obrigatório |
|------|-----------|------|---------|:-----------:|
| role_name | Nome da IAM Role | string | - | sim |
| assume_role_policy | Política de Trust (JSON) | string | - | sim |
| role_description | Descrição da Role | string | "Role criada via Terraform" | não |
| managed_policy_arns | ARNs de políticas gerenciadas | list(string) | [] | não |
| inline_policies | Mapa de políticas inline | map(string) | {} | não |
| tags | Tags adicionais | map(string) | {} | não |

## Outputs
| Nome | Descrição |
|------|-----------|
| role_arn | ARN da Role |
| role_name | Nome da Role |
| role_unique_id | ID único da Role |
