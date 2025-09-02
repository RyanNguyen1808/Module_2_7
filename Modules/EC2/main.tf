locals{
    subnet_ids = var.enable_public_subnet ? data.aws_subnets.public.ids : data.aws_subnets.private.ids
}

resource "aws_instance" "ec2_instance"{
    count                   = var.instance_count
    ami                     = data.aws_ami.amazon_linux2023.id
    instance_type           = var.instance_type
    subnet_id               = local.subnet_ids[count.index % length(local.subnet_ids)]
    vpc_security_group_ids  = [var.ec2_sg]
    associate_public_ip_address = var.enable_public_subnet
    key_name                = var.key_name
    iam_instance_profile   = var.instance_profile_name
    user_data = templatefile("${path.module}/user-data-script.sh", {
        file_content = "ec2-#${count.index}"
        mount_ebs = var.mount_ebs
        mount_efs = var.mount_efs
        efs_dns = var.efs_dns
    })
    tags = {
        Name = "ec2-#${count.index}"
    }
}