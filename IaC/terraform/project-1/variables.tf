variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "ami_id" {
  description = "AMI ID for the instance"
  default     = "ami-0ac4dfaf1c5c0cce9" # Amazon Linux 2 AMI ID
}

variable "instance_type" {
  description = "Type of EC2 instance"
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of the key pair to use for the instance"
  default     = "terraform"
}

variable "security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
  default     = ["sg-12345678"]
}

variable "subnet_id" {
  description = "Subnet ID to launch the instance in"
  default     = "subnet-12345678"
}
