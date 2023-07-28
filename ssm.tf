resource "aws_ssm_association" "stop_database" {
  for_each = toset(var.databases)
  association_name = "stop-${each.value}"

  apply_only_at_cron_interval = var.apply_only_at_cron_interval
  schedule_expression = var.cron_stop
  name = "AWS-StopRdsInstance"
  compliance_severity = "UNSPECIFIED"

  parameters = {
    AutomationAssumeRole: aws_iam_role.ssm_role.arn,
    InstanceId: each.value
  }
  depends_on = [
    aws_iam_role_policy_attachment.attachment
  ]
}


resource "aws_ssm_association" "start_database" {
  for_each = toset(var.databases)
    association_name = "start-${each.value}"

  apply_only_at_cron_interval = var.apply_only_at_cron_interval
  schedule_expression = var.cron_start
  name = "AWS-StartRdsInstance"
  compliance_severity = "UNSPECIFIED"

  parameters = {
    AutomationAssumeRole: aws_iam_role.ssm_role.arn,
    InstanceId: each.value
  }
  depends_on = [
    aws_iam_role_policy_attachment.attachment
  ]
}