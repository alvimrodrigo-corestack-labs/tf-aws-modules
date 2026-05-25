output "db_instance_address" {
  description = "O endereço da instância de banco de dados"
  value       = try(aws_db_instance.this.address, null)
}

output "db_instance_arn" {
  description = "O ARN da instância de banco de dados"
  value       = try(aws_db_instance.this.arn, null)
}

output "db_instance_endpoint" {
  description = "O endpoint de conexão do banco de dados"
  value       = try(aws_db_instance.this.endpoint, null)
}

output "db_instance_identifier" {
  description = "O identificador da instância de banco de dados"
  value       = try(aws_db_instance.this.identifier, null)
}

output "db_instance_resource_id" {
  description = "O ID do recurso da instância de banco de dados"
  value       = try(aws_db_instance.this.resource_id, null)
}

output "db_instance_port" {
  description = "A porta de conexão do banco de dados"
  value       = try(aws_db_instance.this.port, null)
}

output "db_instance_hosted_zone_id" {
  description = "O ID da Hosted Zone do Route53 para o banco de dados"
  value       = try(aws_db_instance.this.hosted_zone_id, null)
}

output "db_password_secret_arn" {
  description = "O ARN do Secret no Secrets Manager contendo as credenciais do banco"
  value       = aws_secretsmanager_secret.this.arn
}
