provider "aws" {
  region     = "us-east-1"
}
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  for_each = toset(["one", "two", "three"])

  name = "instance-${each.key}"

  ami                    = "ami-01b799c439fd5516a"
  instance_type          = "t2.micro"
  key_name               = "newbatch"
  monitoring             = true
  vpc_security_group_ids = ["sg-0f3603543f74d16ab"]
  subnet_id              = "subnet-082574a5d56740791"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
