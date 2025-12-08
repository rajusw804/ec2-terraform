provider "aws" {
  region = "us-east-1" # Or your desired region
}

variable "create_instance" {
  type    = bool
  default = true
}

resource "aws_instance" "example" {
  count         = var.create_instance ? 1 : 0
  ami           = "ami-0fa3fe0fa7920f68e"
  instance_type = "t3.micro"
  key_name = "rajavan"
  tags = {
    Name = "My-Conditional-Instance"
  }
}
