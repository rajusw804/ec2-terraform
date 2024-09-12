provider "aws" {
  region     = "us-east-1"
}
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  for_each = toset(["one", "two", "three"])

  name = "instance-${each.key}"

  ami                    = "ami-0e86e20dae9224db8"
  instance_type          = "t2.micro"
  key_name               = "vpc"
  monitoring             = true
  vpc_security_group_ids = ["sg-0d19342d4c2942b9b"]
  subnet_id              = "subnet-0051dcb35a8f998ca"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
