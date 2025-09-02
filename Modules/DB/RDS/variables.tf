variable "rds_engine" {
  type        = string
  description = "RDS Engine"
}

variable "rds_engine_version" {
  type        = string
  description = "RDS Engine Version"
}

variable "rds_multi_az" {
  type        = bool
  description = "RDS Multi Az"
}

variable "rds_instance_identifier" {
  type        = string
  default     = ""
  description = "RDS Instance Identifier"
}

variable "rds_master_username" {
  type        = string
  description = "RDS Master Username"
}

variable "rds_instance_class" {
  type        = string
  description = "RDS Instance Class"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "rds_allocate_storage" {
  type        = number
  description = "RDS Allocate Storage"
}





