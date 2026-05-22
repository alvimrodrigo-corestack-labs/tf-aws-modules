output "role_arn" {
  description = "O ARN da IAM Role"
  value       = aws_iam_role.this.arn
}

output "role_name" {
  description = "O nome da IAM Role"
  value       = aws_iam_role.this.name
}

output "role_unique_id" {
  description = "O ID único da IAM Role"
  value       = aws_iam_role.this.unique_id
}
