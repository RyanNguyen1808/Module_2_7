resource "aws_efs_file_system" "efs" {
  creation_token = "my-efs"
  encrypted      = true
}

resource "aws_efs_mount_target" "main" {
  for_each        = toset(data.aws_subnets.public.ids)
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = each.value
  security_groups = [var.efs_sg]
}