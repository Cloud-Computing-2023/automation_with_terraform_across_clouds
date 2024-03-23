terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-1"
}
resource "aws_instance" "lopes_instance" {
  ami= "ami-0faac27e2fc42cead"
  instance_type = "t2.micro"

  tags = {
    Name = "lopes_instance"
  }
}