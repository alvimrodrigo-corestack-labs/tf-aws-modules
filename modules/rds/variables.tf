variable "identifier" {
  description = "Identificador do banco de dados RDS"
  type        = string
}

variable "engine" {
  description = "Engine do banco de dados (postgres, mysql, mariadb, sqlserver-ex, etc.)"
  type        = string
}

variable "engine_version" {
  description = "Versão da engine do banco de dados"
  type        = string
}

variable "instance_class" {
  description = "Classe da instância RDS (ex: db.t3.micro)"
  type        = string
}

variable "allocated_storage" {
  description = "Espaço em disco alocado em GB"
  type        = number
  default     = 20
}

variable "max_allocated_storage" {
  description = "Limite máximo para o autoscaling de storage (0 para desativar)"
  type        = number
  default     = 0
}

variable "storage_type" {
  description = "Tipo de storage (gp2, gp3, io1)"
  type        = string
  default     = "gp3"
}

variable "db_name" {
  description = "Nome do banco de dados inicial"
  type        = string
  default     = null
}

variable "username" {
  description = "Username do administrador. Se nulo, será gerado aleatoriamente."
  type        = string
  sensitive   = true
  default     = null
}

variable "password" {
  description = "Password do administrador. Se nulo, será gerado aleatoriamente."
  type        = string
  sensitive   = true
  default     = null
}

variable "port" {
  description = "Porta de conexão do banco de dados"
  type        = number
  default     = null
}

variable "multi_az" {
  description = "Habilita alta disponibilidade Multi-AZ"
  type        = bool
  default     = false
}

variable "publicly_accessible" {
  description = "Define se o banco terá IP público"
  type        = bool
  default     = false
}

variable "subnet_ids" {
  description = "Lista de IDs das subnets para o DB Subnet Group"
  type        = list(string)
}

variable "vpc_security_group_ids" {
  description = "Lista de Security Groups para associar ao RDS"
  type        = list(string)
}

variable "parameter_group_family" {
  description = "Família do Parameter Group (ex: postgres15). Se nulo, não cria custom group."
  type        = string
  default     = null
}

variable "parameters" {
  description = "Lista de parâmetros customizados para o DB Parameter Group"
  type        = list(map(string))
  default     = []
}

variable "backup_retention_period" {
  description = "Dias de retenção de backup"
  type        = number
  default     = 7
}

variable "backup_window" {
  description = "Janela de backup diário (ex: 03:00-04:00)"
  type        = string
  default     = "03:00-04:00"
}

variable "maintenance_window" {
  description = "Janela de manutenção semanal (ex: Mon:00:00-Mon:03:00)"
  type        = string
  default     = "Mon:00:00-Mon:03:00"
}

variable "deletion_protection" {
  description = "Habilita proteção contra exclusão"
  type        = bool
  default     = false
}

variable "skip_final_snapshot" {
  description = "Define se deve pular o snapshot final ao deletar"
  type        = bool
  default     = true
}

variable "storage_encrypted" {
  description = "Habilita criptografia de disco"
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "ARN da chave KMS para criptografia"
  type        = string
  default     = null
}

variable "performance_insights_enabled" {
  description = "Habilita Performance Insights"
  type        = bool
  default     = false
}

variable "monitoring_interval" {
  description = "Intervalo de Enhanced Monitoring em segundos (0 para desativar)"
  type        = number
  default     = 0
}

variable "monitoring_role_arn" {
  description = "ARN da role IAM para Enhanced Monitoring"
  type        = string
  default     = null
}

variable "enabled_cloudwatch_logs_exports" {
  description = "Lista de logs para exportar para o CloudWatch (ex: error, slowquery)"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags aplicadas aos recursos"
  type        = map(string)
  default     = {}
}
