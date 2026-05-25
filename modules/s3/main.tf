resource "aws_s3_bucket" "this" {
  bucket              = var.bucket_name
  force_destroy       = var.force_destroy
  object_lock_enabled = var.object_lock_enabled

  tags = var.tags
}

resource "aws_s3_bucket_versioning" "this" {
  count  = length(keys(var.versioning_configuration)) > 0 ? 1 : 0
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status     = try(var.versioning_configuration["status"], "Enabled")
    mfa_delete = try(var.versioning_configuration["mfa_delete"], "Disabled")
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  count  = length(keys(var.server_side_encryption_configuration)) > 0 ? 1 : 0
  bucket = aws_s3_bucket.this.id

  rule {
    dynamic "apply_server_side_encryption_by_default" {
      for_each = try([var.server_side_encryption_configuration["rule"]["apply_server_side_encryption_by_default"]], [])
      content {
        sse_algorithm     = apply_server_side_encryption_by_default.value.sse_algorithm
        kms_master_key_id = try(apply_server_side_encryption_by_default.value.kms_master_key_id, null)
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

resource "aws_s3_bucket_ownership_controls" "this" {
  count  = var.control_object_ownership ? 1 : 0
  bucket = aws_s3_bucket.this.id

  rule {
    object_ownership = var.object_ownership
  }

  # Ensure public access block is created before ownership controls
  depends_on = [aws_s3_bucket_public_access_block.this]
}

resource "aws_s3_bucket_logging" "this" {
  count  = length(keys(var.logging)) > 0 ? 1 : 0
  bucket = aws_s3_bucket.this.id

  target_bucket = var.logging["target_bucket"]
  target_prefix = try(var.logging["target_prefix"], null)
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  count  = length(var.lifecycle_rules) > 0 ? 1 : 0
  bucket = aws_s3_bucket.this.id

  dynamic "rule" {
    for_each = var.lifecycle_rules
    content {
      id     = try(rule.value.id, null)
      status = try(rule.value.status, "Enabled")

      dynamic "expiration" {
        for_each = try([rule.value.expiration], [])
        content {
          days = try(expiration.value.days, null)
        }
      }

      dynamic "transition" {
        for_each = try(rule.value.transitions, [])
        content {
          days          = try(transition.value.days, null)
          storage_class = transition.value.storage_class
        }
      }

      dynamic "filter" {
        for_each = try([rule.value.filter], [])
        content {
          prefix = try(filter.value.prefix, null)
        }
      }
    }
  }
}

resource "aws_s3_bucket_policy" "this" {
  count  = var.attach_policy ? 1 : 0
  bucket = aws_s3_bucket.this.id
  policy = var.policy

  # Ensure public access block is applied before policy
  depends_on = [aws_s3_bucket_public_access_block.this]
}
