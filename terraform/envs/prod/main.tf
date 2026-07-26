provider "aws" {
  region= "us-east-1"
}

module "s3" {
  source = "../../modules/s3"
  b_name=var.b2_name
}