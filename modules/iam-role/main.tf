resource "aws_iam_role" "this" {
  count = var.create_role ? 1 : 0

  name               = var.role_name
  description        = var.role_description
  assume_role_policy = var.assume_role_policy

  tags = merge(var.tags, {
    ManagedBy = "Terraform"
  })
}

locals {
  role_name = var.create_role ? aws_iam_role.this[0].name : var.role_name
}

resource "aws_iam_role_policy_attachment" "managed" {
  for_each = { for arn in var.managed_policy_arns : arn => arn }

  role       = local.role_name
  policy_arn = each.value
}

resource "aws_iam_role_policy" "inline" {
  for_each = var.inline_policies

  name   = each.key
  role   = local.role_name
  policy = each.value
}
