provider "aws" {
  region     = "us-east-1"
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "single-instance"

  ami                    = "ami-01b799c439fd5516a"
  instance_type          = "t2.micro"
  key_name               = "newbatch"
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
    region         = "us-east-1" # Replace with your desired AWS region
    encrypt        = true
  }
}
