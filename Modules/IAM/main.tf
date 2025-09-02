resource "aws_iam_policy" "policy"{
    name        = "DynamoDBPolicy"
    description = "DynamoDB Scan List Delete Policy"
    policy      = templatefile("${path.module}/policy.json", {
                    resource_arn = var.dynamoDB_table_arn
    })
}

resource "aws_iam_role" "ec2_role" {
    name = "EC2DynamoDBRole"
    assume_role_policy = templatefile("${path.module}/ec2_role.json",{})
}

resource "aws_iam_role_policy_attachment" "ec2_role_policy_attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.policy.arn
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "EC2DynamoDBInstanceProfile"
  role = aws_iam_role.ec2_role.name
}