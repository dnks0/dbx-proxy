data "aws_availability_zones" "this" {
  state = "available"
}

data "aws_ec2_instance_type" "this" {
  instance_type = var.instance_type
}

data "aws_ssm_parameter" "al2023_ami_id" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

data "aws_vpc" "this" {
  id = local.vpc_id
}

data "aws_subnet" "this" {
  for_each = { for idx, id in var.subnet_ids : tostring(idx) => id }
  id       = each.value
}

data "aws_iam_policy_document" "this" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "cloudinit_config" "this" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/cloud-config"
    content      = "#cloud-config\n${yamlencode(local.cloud_config)}"
  }
}
