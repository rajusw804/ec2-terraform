provider "aws" {
  region = "us-east-1" # You can change this to your desired AWS region
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-unique-bucket-name12423"

  tags = {
    Name        = "Managed by Terraform"
    Environment = "Dev"
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

# Proper way to handle private access in modern Terraform
resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.my_bucket.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket                  = aws_s3_bucket.my_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
