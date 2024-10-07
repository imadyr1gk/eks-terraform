#Create a VPC
resource "aws_vpc" "imad_vpc" {
  cidr_block = "10.0.0.0/16"
  tags       = { Name = "imad-vpc" }
}
