variable "name" {
  description = "Nome do cluster ECS"
  type        = string
}

variable "container_insights" {
  description = "Habilita ou desabilita o CloudWatch Container Insights"
  type        = bool
  default     = true
}

variable "fargate_capacity_providers" {
  description = "Lista de capacity providers Fargate para associar ao cluster"
  type        = list(string)
  default     = ["FARGATE", "FARGATE_SPOT"]
}

variable "tags" {
  description = "Tags aplicadas ao cluster"
  type        = map(string)
  default     = {}
}
