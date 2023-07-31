## Provider ##
provider "aws" {
  region = "ap-south-1"
}

## Backend S3 setup ##
terraform {
    backend "s3" {
        bucket = "tf-states-unique13089197"
        key = "backend/terraform.tfstate"
        region = "ap-south-1"
    }
}
## Dynamodb table not created since single person working on project ##
