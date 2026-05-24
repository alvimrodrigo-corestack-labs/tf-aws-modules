terraform {
  source = "../../modules/iam-role"
}

inputs = {
  create_role = false
  role_name   = "my-pre-existing-role"

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
  ]

  inline_policies = {
    "DynamoDBReadOnly" = jsonencode({
      Version = "2012-10-17"
      Statement = [{
        Action   = "dynamodb:GetItem"
        Effect   = "Allow"
        Resource = "*"
      }]
    })
  }
}
