resource "aws_iam_role" "this" {
  name               = var.role_name
  description        = var.role_description
  assume_role_policy = var.assume_role_policy

  managed_policy_arns = var.managed_policy_arns

  tags = merge(var.tags, {
    ManagedBy = "Terraform"
  })
}

resource "aws_iam_role_policy" "inline" {
  for_each = var.inline_policies

  name   = each.key
  role   = aws_iam_role.this.id
  policy = each.value
}
