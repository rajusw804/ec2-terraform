provider "aws" {
  region = "us-east-1"
}

# 1. The Bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-unique-bucket-name12423"

  tags = {
    Name        = "Managed by Terraform"
    Environment = "Dev"
  }

  lifecycle {
    ignore_changes = [tags]
  }
} # Removed the extra } that was here

# 2. Set Ownership
resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.my_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# 3. The ACL Resource
resource "aws_s3_bucket_acl" "example" {
  depends_on = [aws_s3_bucket_ownership_controls.example]

  bucket = aws_s3_bucket.my_bucket.id
  acl    = "private"
}
