output "lb_id" {
  description = "ID do Load Balancer"
  value       = try(aws_lb.this[0].id, null)
}

output "lb_arn" {
  description = "ARN do Load Balancer"
  value       = try(aws_lb.this[0].arn, null)
}

output "lb_dns_name" {
  description = "Nome DNS do Load Balancer"
  value       = try(aws_lb.this[0].dns_name, null)
}

output "lb_zone_id" {
  description = "Zone ID do Load Balancer (para Route53)"
  value       = try(aws_lb.this[0].zone_id, null)
}

output "http_listener_arns" {
  description = "ARNs dos listeners HTTP"
  value       = { for p, l in aws_lb_listener.http : p => l.arn }
}

output "https_listener_arns" {
  description = "ARNs dos listeners HTTPS"
  value       = { for p, l in aws_lb_listener.https : p => l.arn }
}

output "target_group_arns" {
  description = "ARNs dos Target Groups"
  value       = { for n, tg in aws_lb_target_group.this : n => tg.arn }
}

output "target_group_names" {
  description = "Nomes dos Target Groups"
  value       = { for n, tg in aws_lb_target_group.this : n => tg.name }
}
