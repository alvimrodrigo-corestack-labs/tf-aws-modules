variable "name" {
  description = "Nome do repositório ECR"
  type        = string
}

variable "image_tag_mutability" {
  description = "A mutabilidade das tags de imagem. Deve ser MUTABLE ou IMMUTABLE."
  type        = string
  default     = "IMMUTABLE"
}

variable "scan_on_push" {
  description = "Indica se as imagens devem ser escaneadas ao serem enviadas para o repositório."
  type        = bool
  default     = true
}

variable "encryption_type" {
  description = "O tipo de criptografia a ser usado para o repositório. Deve ser AES256 ou KMS."
  type        = string
  default     = "AES256"
}

variable "kms_key" {
  description = "O ARN da chave KMS a ser usada se o tipo de criptografia for KMS."
  type        = string
  default     = null
}

variable "lifecycle_policy" {
  description = "A política de ciclo de vida do repositório em formato JSON. Se não fornecida, nenhuma política será aplicada."
  type        = string
  default     = null
}

variable "force_delete" {
  description = "Se verdadeiro, permite que o repositório seja deletado mesmo que contenha imagens."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags aplicadas ao repositório"
  type        = map(string)
  default     = {}
}
