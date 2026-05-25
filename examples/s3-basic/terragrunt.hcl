terraform {
  source = "../../modules/s3"
}

inputs = {
  bucket_name         = "my-production-bucket-12345"
  force_destroy       = false
  object_lock_enabled = false

  versioning_configuration = {
    status = "Enabled"
  }

  # Modern ownership control
  object_ownership = "BucketOwnerEnforced"

  # Encryption (Default is AES256)
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  # Lifecycle Rules
  lifecycle_rules = [
    {
      id     = "archive-old-objects"
      status = "Enabled"
      filter = {
        prefix = "logs/"
      }
      transitions = [
        {
          days          = 30
          storage_class = "STANDARD_IA"
        },
        {
          days          = 90
          storage_class = "GLACIER"
        }
      ]
      expiration = {
        days = 365
      }
    }
  ]

  tags = {
    Environment = "Prod"
    Department  = "IT"
    ManagedBy   = "Terragrunt"
  }
}
