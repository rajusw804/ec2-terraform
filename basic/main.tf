provider "aws" {
  region = "us-east-1" # Or your desired region
}

resource "aws_instance" "my_ec2_instance" {
  ami           = "ami-0c1fe732b5494dc14"
  instance_type = "t3.micro"
  key_name = "rajavan"

  tags = {
    Name = "myfirstinstance"
  }
}
