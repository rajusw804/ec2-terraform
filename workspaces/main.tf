# terraform workspace new dev
# terraform workspace select dev
# main.tf
variable "instance_type" {
  type    = string
  default = "t3.micro"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0fa3fe0fa7920f68e"
  instance_type = var.instance_type
  tags = {
    Name = "app-server-${terraform.workspace}"
  }
}
