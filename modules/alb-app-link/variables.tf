variable "vpc_id" {
  description = "ID da VPC onde os Target Groups serão criados"
  type        = string
}

variable "listener_arn" {
  description = "ARN do Listener do ALB (ex: porta 80) onde as regras serão adicionadas"
  type        = string
}

variable "app_name" {
  description = "Nome da aplicação (usado para prefixar recursos)"
  type        = string
}

variable "environment" {
  description = "Ambiente (dev, staging, prod)"
  type        = string
}

variable "rules" {
  description = "Configuração das regras de roteamento e target groups"
  type = map(object({
    host_header  = string
    container_port = number
    health_check_path = string
    priority = number
  }))
}

variable "tags" {
  description = "Tags para os recursos"
  type        = map(string)
  default     = {}
}
