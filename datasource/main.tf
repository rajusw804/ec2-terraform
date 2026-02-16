provider "aws" {
  region = "us-east-1" # Or your desired region
}


resource "aws_instance" "app_server" {
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = "t3.micro"
  key_name = "rajavan"
  tags = {
    Name = "My-App-Server"
  }
}

output "ami_details" {
  description = "Details of the AMI found by the data source"
  value = {
    id            = data.aws_ami.latest_amazon_linux.id
    full_name     = data.aws_ami.latest_amazon_linux.name
    creation_date = data.aws_ami.latest_amazon_linux.creation_date
  }
}
