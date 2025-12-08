provider "aws" {
  region = "us-east-1" # Or your desired region
}


variable "instance_count" {
  description = "The number of EC2 instances to create."
  type        = number
  default     = 2 # This will create two instances
}

# Create EC2 instances using the count meta-argument
resource "aws_instance" "example" {

  count = var.instance_count 
  ami           = "ami-0fa3fe0fa7920f68e"
  instance_type = "t3.micro"
  key_name = "rajavan"

  tags = {
    Name = "My-EC2-Instance-${count.index}"
  }
}

output "instance_public_ips" {
  description = "The public IP addresses of the created instances."
  value       = aws_instance.example[*].public_ip
}
