provider "aws" {
  region = "us-east-1" # Or your desired region
}

resource "aws_iam_role" "my_ec2_role" {
  name = "my-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Effect = "Allow",
      },
    ],
  })
}

resource "aws_iam_role_policy_attachment" "my_ec2_policy" {
  role       = aws_iam_role.my_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

resource "aws_instance" "my_instance" {
  ami           = "ami-0fa3fe0fa7920f68e"
  instance_type = "t3.micro"
  key_name = "rajavan"

  depends_on = [
    aws_iam_role_policy_attachment.my_ec2_policy
  ]
}
