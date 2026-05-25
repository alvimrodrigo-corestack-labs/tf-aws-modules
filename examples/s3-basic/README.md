# Exemplo: S3 Basic

Este exemplo demonstra a criação de um bucket S3 com versionamento e criptografia habilitados por padrão, além de bloqueio de acesso público.

## Uso

```hcl
terraform {
  source = "../../modules/s3"
}

inputs = {
  bucket_name        = "meu-bucket-exemplo-12345"
  versioning_enabled = true
  encryption_enabled = true

  tags = {
    Environment = "Dev"
    Project     = "Infrastructure"
    ManagedBy   = "Terragrunt"
  }
}
```
