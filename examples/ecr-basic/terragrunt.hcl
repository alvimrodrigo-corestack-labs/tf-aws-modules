terraform {
  source = "../../modules/ecr"
}

inputs = {
  name = "lab-app-repo"

  lifecycle_policy = jsonencode({
    rules = [{
      rulePriority = 1
      description  = "Expire old images"
      selection = {
        tagStatus     = "any"
        countType     = "imageCountMoreThan"
        countNumber   = 5
      }
      action = {
        type = "expire"
      }
    }]
  })

  tags = {
    Environment = "Lab"
  }
}
