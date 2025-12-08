provider "aws" {
  region = "us-east-1" # Or your desired region
}

variable "ec2_instances" {
  description = "A map of EC2 instance configurations."
  type        = map(any)
  default = {
    web_server = {
      instance_type = "t3.micro"
      ami           = "i-017bab2fde6e2d976"
      key_name = "rajavan"
    }
    app_server = {
      instance_type = "t3.micro"
      ami           = "i-017bab2fde6e2d976"
    }
  }
}

resource "aws_instance" "example" {
  for_each = var.ec2_instances

  # The instance attributes are pulled from the map's values
  instance_type = each.value.instance_type
  ami           = each.value.ami
  key_name = "rajavan"

  tags = {
    # The instance name comes from the map's key
    Name = "My-Server-${each.key}"
  }
}


output "instance_public_ips" {
  description = "The public IP addresses of the created instances."
  value       = { for name, instance in aws_instance.example : name => instance.public_ip }
}
