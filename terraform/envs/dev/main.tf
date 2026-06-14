provider "aws" {
  region = var.r
}


module "S1" {
  source = "../../modules/s3"
  b_name=var.b2_name
}
