resource "aws_dynamodb_table" "dynamoDB"{
    name = var.table_name
    
    hash_key = var.partition_key
    attribute {
        name = var.partition_key
        type = var.partition_key_data_type
    }

    range_key = var.sort_key
    attribute {
        name = var.sort_key
        type = var.sort_key_data_type
    }

    billing_mode     = var.billing_mode
}