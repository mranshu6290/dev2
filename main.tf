provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "my_bucket-i" {
  bucket = "my-unique-bucket-name-6290"
}



output "bucket_name" {
  value = aws_s3_bucket.my_bucket-i.id
}
