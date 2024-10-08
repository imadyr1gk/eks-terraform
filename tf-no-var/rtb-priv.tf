# Routing table pour  private subnet Availability Zone A 

resource "aws_route_table" "imad-rtb-prv" {
  vpc_id = aws_vpc.imad_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.imad-ngw.id
  }

  tags = {
    Name = "imad-rtb-prv"
  }
}

#route table association
resource "aws_route_table_association" "a-prv" {
  subnet_id      = aws_subnet.subnet_prv1.id
  route_table_id = aws_route_table.imad-rtb-prv.id
}

resource "aws_route_table_association" "b-prv" {
  subnet_id      = aws_subnet.subnet_prv2.id
  route_table_id = aws_route_table.imad-rtb-prv.id
}

resource "aws_route_table_association" "c-prv" {
  subnet_id      = aws_subnet.subnet_prv3.id
  route_table_id = aws_route_table.imad-rtb-prv.id
}
