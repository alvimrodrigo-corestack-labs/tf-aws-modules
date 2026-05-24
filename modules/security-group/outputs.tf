output "security_group_id" {
  description = "ID do Security Group criado"
  value       = try(aws_security_group.this[0].id, null)
}

output "security_group_arn" {
  description = "ARN do Security Group criado"
  value       = try(aws_security_group.this[0].arn, null)
}

output "security_group_name" {
  description = "Nome do Security Group criado"
  value       = try(aws_security_group.this[0].name, null)
}

output "security_group_vpc_id" {
  description = "VPC ID do Security Group"
  value       = try(aws_security_group.this[0].vpc_id, null)
}
