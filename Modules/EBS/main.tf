resource "aws_ebs_volume" "ebs" {
  availability_zone = var.availability_zone
  size              = var.size
  encrypted         = var.encrypted
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = var.device_name
  volume_id   = aws_ebs_volume.ebs.id
  instance_id = var.ec2_instance_id
}