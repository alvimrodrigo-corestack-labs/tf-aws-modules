variable "create" {
  description = "Define se o ALB deve ser criado"
  type        = bool
  default     = true
}

variable "name" {
  description = "Nome do ALB"
  type        = string
}

variable "internal" {
  description = "Define se o ALB é interno (true) ou público (false)"
  type        = bool
  default     = false
}

variable "load_balancer_type" {
  description = "Tipo de Load Balancer. Deve ser 'application'"
  type        = string
  default     = "application"
}

variable "security_groups" {
  description = "Lista de IDs de Security Groups para associar ao ALB"
  type        = list(string)
}

variable "subnets" {
  description = "Lista de IDs de Subnets para o ALB"
  type        = list(string)
}

variable "idle_timeout" {
  description = "Tempo de idle timeout em segundos"
  type        = number
  default     = 60
}

variable "enable_deletion_protection" {
  description = "Habilita proteção contra exclusão acidental"
  type        = bool
  default     = false
}

variable "enable_cross_zone_load_balancing" {
  description = "Habilita Cross-Zone Load Balancing"
  type        = bool
  default     = true
}

variable "access_logs_bucket" {
  description = "Nome do bucket S3 para armazenar logs de acesso (opcional)"
  type        = string
  default     = null
}

variable "access_logs_prefix" {
  description = "Prefixo para os logs de acesso no S3"
  type        = string
  default     = ""
}

variable "access_logs_enabled" {
  description = "Habilita ou desabilita logs de acesso"
  type        = bool
  default     = false
}

variable "vpc_id" {
  description = "ID da VPC"
  type        = string
}

# Listeners
variable "http_tcp_listeners" {
  description = "Lista de mapas para listeners HTTP/TCP"
  type        = any
  default     = []
}

variable "https_listeners" {
  description = "Lista de mapas para listeners HTTPS"
  type        = any
  default     = []
}

# Target Groups
variable "target_groups" {
  description = "Lista de mapas para Target Groups"
  type        = any
  default     = []
}

# Listener Rules
variable "extra_ssl_certs" {
  description = "Lista de certificados SSL adicionais"
  type        = list(map(string))
  default     = []
}

variable "waf_web_acl_arn" {
  description = "ARN da Web ACL do WAF para associar ao ALB"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags aplicadas aos recursos"
  type        = map(string)
  default     = {}
}
