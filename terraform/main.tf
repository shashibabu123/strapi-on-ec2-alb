provider "aws" {
  region = "us-east-1"
}

# Include other components
# This assumes you split your config into sg.tf, ec2.tf, alb.tf, etc.

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.3.0"
}

