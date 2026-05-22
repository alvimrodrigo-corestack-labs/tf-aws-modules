variable "name" {
  description = "Nome base para os recursos da VPC"
  type        = string
}

variable "cidr_block" {
  description = "Bloco CIDR para a VPC"
  type        = string
}

variable "availability_zones" {
  description = "Lista de Availability Zones para as subnets"
  type        = list(string)
}

variable "public_subnets" {
  description = "Lista de CIDRs para as subnets públicas"
  type        = list(string)
  default     = []
}

variable "private_subnets" {
  description = "Lista de CIDRs para as subnets privadas"
  type        = list(string)
  default     = []
}

variable "enable_nat_gateway" {
  description = "Habilita a criação de NAT Gateways para subnets privadas"
  type        = bool
  default     = false
}

variable "single_nat_gateway" {
  description = "Se true, cria apenas um NAT Gateway para todas as subnets privadas (reduz custos em labs)"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags aplicadas aos recursos"
  type        = map(string)
  default     = {}
}
