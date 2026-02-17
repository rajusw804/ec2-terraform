# Provisioner:
# Local exec  : Runs on the machine where terraform installed
# file : Sending files from terraform machine other machines
# remote-exec : Runs the scripts/commands on remote machine

provider "aws" {
  region = "us-east-1"
}

# 1. Automatically generate an SSH Key Pair (Replaces manual ssh-keygen)
resource "tls_private_key" "main_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# 2. Register the Public Key with AWS
resource "aws_key_pair" "deployer" {
  key_name   = "terraform-key"
  public_key = tls_private_key.main_key.public_key_openssh
}

# 3. Create the EC2 Instance
resource "aws_instance" "web_server" {
  ami           = "ami-0b6c6ebed2801a5cb" # Ensure this matches your region!
  instance_type = "t3.micro"
  key_name      = aws_key_pair.deployer.key_name

  # Security Group (REQUIRED for SSH to work)
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "Web-Server"
  }

  # Connection block for remote-exec and file provisioners
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = tls_private_key.main_key.private_key_pem
    host        = self.public_ip
  }

  # LOCAL-EXEC: Saves the private key locally (so you can SSH manually later)
  provisioner "local-exec" {
    command = <<EOT
      echo "${tls_private_key.main_key.private_key_pem}" > ./id_rsa
      chmod 400 ./id_rsa
      echo "Server IP: ${self.public_ip}" >> inventory.txt
    EOT
  }

  # FILE: Sending the setup script
  provisioner "file" {
    source      = "setup.sh"
    destination = "/tmp/setup.sh"
  }

  # REMOTE-EXEC: Running the script
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/setup.sh",
      "sudo /tmp/setup.sh"
    ]
  }
}

# 4. Security Group to allow SSH (otherwise provisioners will fail/timeout)
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh_traffic"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # In production, change this to your IP!
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "instance_public_ip" {
  value = aws_instance.web_server.public_ip
}
