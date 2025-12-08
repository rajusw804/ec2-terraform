provider "aws" {
  region = "us-east-1" # Or your desired region
}

resource "aws_instance" "example" {
  ami           = "ami-0fa3fe0fa7920f68e"
  key_name = "rajavan"
  tags = {
    Name = "My-Terraform-EC2-Instance"
  }
}

terraform {
  backend "s3" {
    bucket         = "rakesh-terraform-practice1" # Replace with your S3 bucket name
    key            = "terraform.tfstate" # Key is the name of the state file in the bucket
    region         = "us-east-1" # Replace with your desired AWS region
    encrypt        = true
  }
}
