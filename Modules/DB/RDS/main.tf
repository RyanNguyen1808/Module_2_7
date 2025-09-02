resource "aws_db_instance" "rds" {
    engine = var.rds_engine
    engine_version = var.rds_engine_version
    multi_az = var.rds_multi_az
    identifier = var.rds_instance_identifier
    username = var.rds_master_username
    manage_master_user_password = true
    instance_class     = var.rds_instance_class
    db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
    vpc_security_group_ids  = [aws_security_group.rds_sg.id]
    allocated_storage = var.rds_allocate_storage
    skip_final_snapshot = true
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = data.aws_subnets.private.ids

  tags = {
    Name = "RDS Subnet Group"
  }
}