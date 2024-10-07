# Routing table pour  private subnet dans AZ A 

resource "aws_route_table" "imad-rtb-pub" {
  vpc_id = aws_vpc.imad_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.imad-igw.id
  }

  tags = {
    Name = "imad-rtb-pub"
  }
}

#route table association
resource "aws_route_table_association" "a-pub" {
  subnet_id      = aws_subnet.subnet_pub1.id
  route_table_id = aws_route_table.imad-rtb-pub.id
}

resource "aws_route_table_association" "b-pub" {
  subnet_id      = aws_subnet.subnet_pub2.id
  route_table_id = aws_route_table.imad-rtb-pub.id
}

resource "aws_route_table_association" "c-pub" {
  subnet_id      = aws_subnet.subnet_pub3.id
  route_table_id = aws_route_table.imad-rtb-pub.id
}
