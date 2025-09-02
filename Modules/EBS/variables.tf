variable "availability_zone" {
  type        = string
  description = "Ebs Availability Zone"
}

variable "size" {
  type        = number
  description = "EBS Size in Gb"
}

variable "encrypted" {
  type        = bool
  description = "EBS Encryption"
}

variable "ec2_instance_id" {
  type        = string
  description = "EC2 Instance Id"
}

variable "device_name" {
  type        = string
  description = "EBS Attach Device Name"
}





