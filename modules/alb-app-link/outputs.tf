output "target_group_arns" {
  description = "Mapa de ARNs dos Target Groups criados"
  value       = { for k, v in aws_lb_target_group.this : k => v.arn }
}
