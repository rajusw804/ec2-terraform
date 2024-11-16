provider "aws" {
  region     = "us-east-1"
}
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  for_each = toset(["one", "two", "three"])

  name = "instance-${each.key}"

  ami                    = "ami-012967cc5a8c9f891"
  instance_type          = "t2.micro"
  key_name               = "vpc"
  monitoring             = true
  vpc_security_group_ids = ["sg-088ecb59a8078e11c"]
  subnet_id              = "subnet-0051dcb35a8f998ca"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
