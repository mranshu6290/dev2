provider "aws" {
  region = var.r
}


module "s3" {
  source = "../../modules/s3"
  b_names2 = var.b2_name
}
