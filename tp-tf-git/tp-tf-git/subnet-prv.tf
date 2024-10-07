resource "aws_subnet" "subnet_prv1" {
  vpc_id                  = aws_vpc.imad_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet_prv1"
  }
}



resource "aws_subnet" "subnet_prv2" {
  vpc_id                  = aws_vpc.imad_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet_prv2"
  }
}


resource "aws_subnet" "subnet_prv3" {
  vpc_id                  = aws_vpc.imad_vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet_prv3"
  }
}

