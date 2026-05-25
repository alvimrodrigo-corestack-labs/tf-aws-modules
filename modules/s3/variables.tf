variable "bucket_name" {
  description = "The name of the bucket. If omitted, Terraform will assign a random, unique name."
  type        = string
  default     = null
}

variable "force_destroy" {
  description = "A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error."
  type        = bool
  default     = false
}

variable "object_lock_enabled" {
  description = "Indicates whether this bucket has an Object Lock configuration enabled."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A mapping of tags to assign to the bucket."
  type        = map(string)
  default     = {}
}

# Versioning
variable "versioning_configuration" {
  description = "Map containing versioning configuration."
  type        = map(string)
  default = {
    status     = "Enabled"
    mfa_delete = "Disabled"
  }
}

# Server Side Encryption
variable "server_side_encryption_configuration" {
  description = "Map containing server-side encryption configuration."
  type        = any
  default = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }
}

# Public Access Block
variable "block_public_acls" {
  description = "Whether Amazon S3 should block public ACLs for this bucket."
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Whether Amazon S3 should block public bucket policies for this bucket."
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "Whether Amazon S3 should ignore public ACLs for this bucket."
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "Whether Amazon S3 should restrict public bucket policies for this bucket."
  type        = bool
  default     = true
}

# Ownership Controls
variable "control_object_ownership" {
  description = "Whether to manage S3 Bucket Ownership Controls. Defaults to true."
  type        = bool
  default     = true
}

variable "object_ownership" {
  description = "Object ownership. Valid values: BucketOwnerPreferred, ObjectWriter or BucketOwnerEnforced."
  type        = string
  default     = "BucketOwnerEnforced"
}

# Logging
variable "logging" {
  description = "Map containing access bucket logging configuration."
  type        = map(string)
  default     = {}
}

# Lifecycle Rules
variable "lifecycle_rules" {
  description = "List of maps containing configuration of object lifecycle management."
  type        = any
  default     = []
}

# Bucket Policy
variable "attach_policy" {
  description = "Controls if S3 bucket policy should be attached."
  type        = bool
  default     = false
}

variable "policy" {
  description = "A valid bucket policy JSON document. Required if attach_policy is true."
  type        = string
  default     = null
}
