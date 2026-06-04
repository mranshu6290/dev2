terraform {
  backend "s3" {
    bucket         = "my-unique-bucket-name-6290"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  //  dynamodb_table = "terraform-locks"
  }
}

provider "aws" {
  region = "us-east-1"
}



resource "aws_s3_bucket" "my_bucket-k" {
  bucket = "my-unique-bucket-name-62903"
}



output "bucket_name" {
  value = aws_s3_bucket.my_bucket-k.id
}
