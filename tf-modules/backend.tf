terraform {
  backend "s3" {
    bucket = "imadgrps3"
    key    = "terraform.tfstate"
    region = "us-west-1"
  }
}

