provider "aws" {
  region     = "ap-south-1"
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "single-instance"

  ami                    = "ami-04f8d7ed2f1a54b14"
  instance_type          = "t2.micro"
  key_name               = "testdd"
  monitoring             = true
  
  tags = {
    Name = "terraform-instance"
    Terraform   = "true"
    Environment = "prod"
  }
}
terraform {
  backend "s3" {
    bucket         = "rudram" # Replace with your S3 bucket name
    key            = "terraform.tfstate" # Key is the name of the state file in the bucket
    region         = "ap-south-1" # Replace with your desired AWS region
    encrypt        = true
  }
}
