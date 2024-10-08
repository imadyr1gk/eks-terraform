#Create a VPC
resource "aws_vpc" "imad_vpc" {
  cidr_block = var.vpc_cidr
  tags       = { Name = "imad-vpc" }
}
