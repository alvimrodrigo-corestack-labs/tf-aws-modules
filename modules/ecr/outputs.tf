output "repository_url" {
  description = "A URL do repositório ECR"
  value       = aws_ecr_repository.this.repository_url
}

output "repository_arn" {
  description = "O ARN do repositório ECR"
  value       = aws_ecr_repository.this.arn
}

output "repository_name" {
  description = "O nome do repositório ECR"
  value       = aws_ecr_repository.this.name
}

output "registry_id" {
  description = "O ID do registro onde o repositório foi criado"
  value       = aws_ecr_repository.this.registry_id
}
