output "role_arn" {
  description = "O ARN da IAM Role"
  value       = try(aws_iam_role.this[0].arn, null)
}

output "role_name" {
  description = "O nome da IAM Role"
  value       = local.role_name
}

output "role_unique_id" {
  description = "O ID único da IAM Role"
  value       = try(aws_iam_role.this[0].unique_id, null)
}
