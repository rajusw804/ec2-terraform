provider "aws" {
  region = "ap-south-1" # You can change this to your desired AWS region
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-unique-bucket-name1223"
  acl    = "private"

  tags = {
    Name        = "Managed by Terraform"
    Environment = "Dev"
  }

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}
