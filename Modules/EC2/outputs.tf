output "ec2_instance_id" {
  value = aws_instance.ec2_instance[*].id
}

output "ec2_instance_availability_zone"{
  value = aws_instance.ec2_instance[*].availability_zone
}

