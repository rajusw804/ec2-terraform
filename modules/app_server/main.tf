# This is the code inside the module
resource "aws_instance" "app" {
  ami           = var.ami
  instance_type = var.instance_type
  tags = {
    Name = var.server_name
  }
}
