resource "aws_eip" "imad_eip" {
  #instance = aws_instance.web.id
  domain = "vpc"
  # vpc   = true
}

resource "aws_nat_gateway" "imad-ngw" {
  allocation_id = aws_eip.imad_eip.id
  subnet_id     = aws_subnet.subnet_pub3.id

  tags = {
    Name = "imad-ngw"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  #depends_on = [aws_internet_gateway.example]
}
