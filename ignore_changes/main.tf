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
