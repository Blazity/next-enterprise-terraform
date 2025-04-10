terraform {
    backend "s3" {
        # replace with your bucket name.
        bucket = "next-enterprise-terraform"

        key    = "next-enterprise-terraform.tfstate"
        region = "eu-west-2"
    }
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 5.0"
        }
    }
}
