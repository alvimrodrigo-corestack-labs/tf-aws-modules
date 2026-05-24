terraform {
  source = "../../modules/iam-role"
}

inputs = {
  create_role = true
  role_name   = "example-service-role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  ]

  inline_policies = {
    "S3ListAllBuckets" = jsonencode({
      Version = "2012-10-17"
      Statement = [{
        Action   = "s3:ListAllMyBuckets"
        Effect   = "Allow"
        Resource = "*"
      }]
    })
  }

  tags = {
    Environment = "dev"
  }
}
