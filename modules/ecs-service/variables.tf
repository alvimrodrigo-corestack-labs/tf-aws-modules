variable "name" {
  description = "Nome do serviço e da task definition"
  type        = string
}

variable "cluster_arn" {
  description = "ARN do cluster ECS onde o serviço será executado"
  type        = string
}

variable "launch_type" {
  description = "Tipo de lançamento (FARGATE ou EC2)"
  type        = string
  default     = "FARGATE"
}

variable "cpu" {
  description = "CPU da Task (Ex: 256 para 0.25 vCPU)"
  type        = number
  default     = 256
}

variable "memory" {
  description = "Memória da Task (Ex: 512 para 512MB)"
  type        = number
  default     = 512
}

variable "desired_count" {
  description = "Número desejado de instâncias da task"
  type        = number
  default     = 1
}

variable "container_definitions" {
  description = "JSON com a definição dos containers (Task Definition)"
  type        = string
}

variable "subnets" {
  description = "Lista de subnets para o serviço (obrigatório para awsvpc network mode)"
  type        = list(string)
}

variable "security_groups" {
  description = "Lista de Security Groups para o serviço"
  type        = list(string)
}

variable "target_group_arn" {
  description = "ARN do Target Group do ALB para integrar o serviço"
  type        = string
  default     = null
}

variable "container_name" {
  description = "Nome do container para mapeamento no Load Balancer"
  type        = string
  default     = null
}

variable "container_port" {
  description = "Porta do container para mapeamento no Load Balancer"
  type        = number
  default     = null
}

variable "enable_execute_command" {
  description = "Habilita o ECS Exec"
  type        = bool
  default     = true
}

variable "assign_public_ip" {
  description = "Atribui IP público às tarefas (necessário se subnets forem públicas)"
  type        = bool
  default     = false
}

variable "health_check_grace_period_seconds" {
  description = "Segundos para ignorar falhas de health check do ALB no startup"
  type        = number
  default     = 0
}

variable "tags" {
  description = "Tags para os recursos do serviço"
  type        = map(string)
  default     = {}
}
