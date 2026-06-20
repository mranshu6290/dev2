resource "aws_s3_bucket" "this" {

  for_each = var.b_name
  bucket   = each.value
}
