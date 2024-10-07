resource "aws_internet_gateway" "imad-igw" {
  vpc_id = aws_vpc.imad_vpc.id

  tags = {
    Name = "imad-igw"
  }
}
