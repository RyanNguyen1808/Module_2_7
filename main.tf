# module "dynamoDB"{
#   source = "./Modules/DB/DynamoDB"

#   table_name = "ryan-bookinventory"
#   partition_key = "ISBN"
#   partition_key_data_type = "S"
#   sort_key = "Genre"
#   sort_key_data_type = "S"
# }

# module "iam"{
#     source = "./Modules/IAM"
#     dynamoDB_table_arn = module.dynamoDB.table_arn
# }

# module "efs" {
#   source = "./Modules/EFS"
#   vpc_id = "vpc-0bdb0cb7149a39365"
#   efs_sg = module.efs_sg.id
# }

# Create EFS SG that allows NFS from EC2 SG
# module "efs_sg" {
#   source = "./Modules/SECURITY_GROUP"
#   vpc_id = "vpc-0bdb0cb7149a39365"
#   name   = "efs-sg"
#   ingress_rules = [
#     {
#       from_port       = 2049
#       to_port         = 2049
#       protocol        = "tcp"
#       security_groups = [module.ec2_sg.id]
#     }
#   ]
# }

module "ebs"{
  source = "./Modules/EBS"

  for_each = { for idx, id in module.ec2.ec2_instance_id : idx => id }
  
  availability_zone = module.ec2.ec2_instance_availability_zone[each.key]
  size = 1
  encrypted = true
  ec2_instance_id = each.value
  device_name = "/dev/sdb"
}

module "ec2" {
  source         = "./Modules/EC2"
  instance_type  = "t3.micro"
  instance_count = 1
  vpc_id         = "vpc-0bdb0cb7149a39365"
  enable_public_subnet  = true
  key_name = "ec2 key pair"
  ec2_sg = module.ec2_sg.id
  #instance_profile_name = module.iam.ec2_instance_profile_name
  mount_ebs = true
  mount_efs = false
  //efs_dns = module.efs.efs_dns
}

# Create EC2 Security Group
module "ec2_sg" {
  source = "./Modules/SECURITY_GROUP"
  vpc_id = "vpc-0bdb0cb7149a39365"
  name   = "ec2-sg"
  ingress_rules = [
    {
      from_port       = 22
      to_port         = 22
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
    }
  ]
}

