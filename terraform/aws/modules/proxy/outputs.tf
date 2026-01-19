output "iam_role_name" {
  description = "IAM role name for dbx-proxy instances."
  value       = aws_iam_role.this.name
}

output "iam_role_arn" {
  description = "IAM role ARN for dbx-proxy instances."
  value       = aws_iam_role.this.arn
}

output "instance_profile_name" {
  description = "IAM instance profile name for dbx-proxy instances."
  value       = aws_iam_instance_profile.this.name
}

output "instance_profile_arn" {
  description = "IAM instance profile ARN for dbx-proxy instances."
  value       = aws_iam_instance_profile.this.arn
}

output "security_group_id" {
  description = "ID of the security group attached to dbx-proxy instances."
  value       = aws_security_group.this.id
}

output "autoscaling_group_name" {
  description = "Name of the Auto Scaling Group managing dbx-proxy instances."
  value       = aws_autoscaling_group.this.name
}

output "launch_template_name" {
  description = "Launch template Name for dbx-proxy instances."
  value       = aws_launch_template.this.name
}

output "dbx_proxy_cfg" {
  description = "Rendered dbx-proxy config (dbx-proxy.cfg)."
  value       = module.common.dbx_proxy_cfg
}
