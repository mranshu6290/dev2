provider "aws" {

  region = var.r

}


module "s3" {
  source = "../../modules/s3"
  //b_name = var.b2_name

for_each = var.b2_name
b_name = each.value

}

