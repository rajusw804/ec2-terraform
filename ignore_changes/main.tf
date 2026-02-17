provider "aws" {
  region = "us-east-1" # You can change this to your desired AWS region
}

# 1. The Bucket (Clean)
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-unique-bucket-name12423"

  tags = {
    Name        = "Managed by Terraform"
    Environment = "Dev"
  }
}

# 2. Set Ownership (Required before setting ACLs)
resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.my_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# 3. The New ACL Resource (Replaces the deprecated line)
resource "aws_s3_bucket_acl" "example" {
  depends_on = [aws_s3_bucket_ownership_controls.example]

  bucket = aws_s3_bucket.my_bucket.id
  acl    = "private"
}
