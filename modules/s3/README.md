# Advanced S3 Module

Production-grade S3 bucket module supporting AWS Provider 5.x features, including Ownership Controls, Lifecycle Rules, and granular configurations.

## Features

- **Ownership Controls**: Support for `BucketOwnerEnforced` (modern default).
- **Security**: Encryption (SSE-S3/SSE-KMS) and Public Access Block enabled by default.
- **Flexibility**: Support for Logging, Lifecycle Rules, and custom Bucket Policies.
- **Modern**: Compatible with Terraform 1.5+ and AWS Provider 5.x.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.5 |
| aws | >= 5.0 |

## Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| bucket\_name | The name of the bucket. | `string` | `null` |
| force\_destroy | Delete all objects on destruction. | `bool` | `false` |
| versioning\_configuration | Map for versioning status. | `map(string)` | `{status = "Enabled"}` |
| server\_side\_encryption\_configuration | Encryption configuration. | `any` | `SSE-S3 enabled` |
| control\_object\_ownership | Manage Ownership Controls. | `bool` | `true` |
| object\_ownership | Ownership strategy. | `string` | `BucketOwnerEnforced` |
| logging | Logging configuration. | `map(string)` | `{}` |
| lifecycle\_rules | List of lifecycle management rules. | `any` | `[]` |
| attach\_policy | Attach a bucket policy. | `bool` | `false` |
| policy | JSON bucket policy. | `string` | `null` |
| tags | Resource tags. | `map(string)` | `{}` |

## Outputs

| Name | Description |
|------|-------------|
| bucket\_id | The name of the bucket. |
| bucket\_arn | The ARN of the bucket. |
| bucket\_domain\_name | The bucket domain name. |
| bucket\_regional\_domain\_name | The regional domain name. |
| bucket\_region | The AWS region. |
