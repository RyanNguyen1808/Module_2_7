variable "instance_count" {
  type        = number
  description = "Number of Created Instance"
}

variable "instance_type"{
    type = string
    description = "Instance Type"
}

variable "enable_public_subnet"{
    type = bool
    description = "Enable Public Subnet"
}

variable "vpc_id"{
    type = string
    description = "VPC ID"
}

variable "key_name" {
  type        = string
  description = "Key Name"
}

variable "instance_profile_name" {
  type        = string
  default     = ""
  description = "description"
}

variable "mount_ebs" {
  type        = bool
  description = "Mount EBS"
}

variable "mount_efs" {
  type        = bool
  description = "Mount EFS"
}

variable "efs_dns" {
  type        = string
  default     = ""
  description = "EFS DNS"
}

variable "ec2_sg" {
  type        = string
  description = "EC2 Security Group"
}





