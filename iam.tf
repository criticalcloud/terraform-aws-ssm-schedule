resource "aws_iam_policy" "policy" {
  name        = var.policy_name
  path        = "/"
  description = var.default_description

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
            "rds:Describe*",
            "rds:Start*",
            "rds:Stop*",
            "rds:Reboot*"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role" "ssm_role" {
  name = var.role_name
  description = var.default_description

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ssm.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attachment" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = aws_iam_policy.policy.arn
}