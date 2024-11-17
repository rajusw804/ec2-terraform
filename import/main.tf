provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "console" {
  ami = "ami-0866a3c8686eaeeba"
  instance = "t2.micro"
}
