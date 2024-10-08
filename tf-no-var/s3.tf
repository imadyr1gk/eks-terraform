resource "aws_s3_bucket" "imad-s3" {
  bucket = "imad-s3"

  tags = {
    Name        = "imad-s3"
    Environment = "Dev"
  }
}
