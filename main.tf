terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example"{
    ami = "ami-40d28157"
    instance_type = "t2.micro"

    tags = {
        Name = "terraform-example"
    }
}

#Template
# resource "PROVIDER_TYPE" "NAME"{
    # [CONFIG...]
# }