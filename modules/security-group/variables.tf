variable "create" {
  description = "Indica se o Security Group deve ser criado"
  type        = bool
  default     = true
}

variable "name" {
  description = "Nome do Security Group"
  type        = string
}

variable "description" {
  description = "Descrição do Security Group"
  type        = string
  default     = "Security Group gerenciado via Terraform"
}

variable "vpc_id" {
  description = "ID da VPC onde o Security Group será criado"
  type        = string
}

variable "ingress_rules" {
  description = "Lista de regras de entrada"
  type = list(object({
    from_port        = number
    to_port          = number
    protocol         = string
    description      = optional(string)
    cidr_blocks      = optional(list(string))
    ipv6_cidr_blocks = optional(list(string))
    security_groups  = optional(list(string))
    prefix_list_ids  = optional(list(string))
    self             = optional(bool)
  }))
  default = []
}

variable "egress_rules" {
  description = "Lista de regras de saída"
  type = list(object({
    from_port        = number
    to_port          = number
    protocol         = string
    description      = optional(string)
    cidr_blocks      = optional(list(string))
    ipv6_cidr_blocks = optional(list(string))
    security_groups  = optional(list(string))
    prefix_list_ids  = optional(list(string))
    self             = optional(bool)
  }))
  default = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow all outbound traffic"
    }
  ]
}

variable "tags" {
  description = "Tags aplicadas ao Security Group"
  type        = map(string)
  default     = {}
}
