variable "table_name" {
  type        = string
  description = "Dynamo DB Table Name"
}

variable "partition_key" {
  type        = string
  description = "Partition Key"
}

variable "partition_key_data_type" {
  type        = string
  description = "Partition Key Data Type"
}

variable "sort_key" {
  type        = string
  description = "Sort Key"
}

variable "sort_key_data_type" {
  type        = string
  description = "Sort Key Data Type"
}

variable "billing_mode" {
  type        = string
  description = "Billing Mode"
  default = "PAY_PER_REQUEST"
}

