resource "aws_subnet" "subnet_pub1" {
  vpc_id                  = aws_vpc.imad_vpc.id
  cidr_block              = var.public_subnets_cidrs[0]
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet_pub1"
  }
}



resource "aws_subnet" "subnet_pub2" {
  vpc_id                  = aws_vpc.imad_vpc.id
  cidr_block              = var.public_subnets_cidrs[1]
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet_pub2"
  }
}


resource "aws_subnet" "subnet_pub3" {
  vpc_id                  = aws_vpc.imad_vpc.id
  cidr_block              = var.public_subnets_cidrs[2]
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet_pub3"
  }
}

