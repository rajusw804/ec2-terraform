provider "aws" {
  region = "us-east-1" # Or your desired region
}

module "dev_app_server" {
  source = "/home/ec2-user/ec2-terraform/modules/app_server"


  ami           = "ami-0fa3fe0fa7920f68e"
  instance_type = "t3.micro"
  server_name   = "dev-web-app"
}

module "prod_app_server" {
  source = "/home/ec2-user/ec2-terraform/modules/app_server"

  ami           = "ami-0fa3fe0fa7920f68e"
  instance_type = "t3.micro"
  server_name   = "prod-web-app"
}

output "dev_instance_id" {
  value = module.dev_app_server.instance_id
}
