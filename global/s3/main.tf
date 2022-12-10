terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    bucket = "terraform-up-and-running-state-hyunsoo"
    key = "stage/service/webserver-cluster/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    dynamodb_table = "terraform-up-and-running-lock"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-up-and-running-state-hyunsoo"

  versioning{
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_dynamodb_table" "terraform_lock" {
    name = "terraform-up-and-running-lock"
    hash_key = "LockID"
    read_capacity = 2
    write_capacity = 2

    attribute {
      name = "LockID"
      type = "S"
    }  
}

output "s3_bucket_arn" {
    value = "${aws_s3_bucket.terraform_state.arn}"
}