# Provider configuration
provider "aws" {
  region = var.region
}

# EC2 Instance resource
resource "aws_instance" "example" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id

  vpc_security_group_ids = var.security_group_ids

  tags = {
    Name = "ExampleInstance"
  }
}
