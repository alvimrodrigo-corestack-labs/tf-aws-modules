variable "role_name" {
  description = "Nome da IAM Role"
  type        = string
}

variable "role_description" {
  description = "Descrição da IAM Role"
  type        = string
  default     = "Role criada via Terraform"
}

variable "assume_role_policy" {
  description = "A política de confiança (Trust Relationship) em formato JSON"
  type        = string
}

variable "managed_policy_arns" {
  description = "Lista de ARNs de políticas gerenciadas para anexar à role"
  type        = list(string)
  default     = []
}

variable "inline_policies" {
  description = "Mapa de políticas inline para criar e anexar à role { nome = json }"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags aplicadas à Role"
  type        = map(string)
  default     = {}
}
