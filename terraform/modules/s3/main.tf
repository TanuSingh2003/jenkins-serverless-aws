resource "aws_s3_bucket" "static" {
  bucket = "notes-static-${random_id.suffix.hex}"
  force_destroy = true
}

resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.static.id
  versioning_configuration { status = "Enabled" }
}

output "bucket_name" {
  value = aws_s3_bucket.static.bucket
}

