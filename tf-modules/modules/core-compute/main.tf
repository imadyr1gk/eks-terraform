provider "aws" {
  region = var.aws_region
}

# Créer un VPC
resource "aws_vpc" "imad_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
}

# Créer des sous-réseaux publics
#resource "aws_subnet" "imad_public_subnet" {
#  count                   = 3
# vpc_id                  = aws_vpc.imad_vpc.id
#cidr_block              = element(var.public_subnets_cidrs, count.index)
#map_public_ip_on_launch = true
#}

# Sous-réseaux publics
resource "aws_subnet" "imad_public_subnet" {
  count                   = length(var.public_subnets_cidrs)
  vpc_id                  = aws_vpc.imad_vpc.id
  cidr_block              = var.public_subnets_cidrs[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names)]
  map_public_ip_on_launch = true
  tags = {
    Name = "imad_public_subnet-${count.index + 1}"
  }
}

# Sous-réseaux privés
resource "aws_subnet" "imad_private_subnet" {
  count             = length(var.private_subnets_cidrs)
  vpc_id            = aws_vpc.imad_vpc.id
  cidr_block        = var.private_subnets_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names)]
  tags = {
    Name = "imad_private_subnet-${count.index + 1}"
  }
}



# Créer des sous-réseaux privés
#resource "aws_subnet" "imad_private_subnet" {
# count      = 3
# vpc_id     = aws_vpc.imad_vpc.id
# cidr_block = element(var.private_subnets_cidrs, count.index)
#}


# Créer un groupe de sécurité
resource "aws_security_group" "imad_sg" {
  name        = "imad-security-group"
  description = "Security group for EC2 instances"
  vpc_id      = aws_vpc.imad_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # SSH
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # HTTP
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # HTTPS
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "imad-sg"
  }
}


# Créer une instance EC2
resource "aws_instance" "imad_ec2_instance" {
  ami                    = data.aws_ami.amazon-linux-2023.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.imad_public_subnet[0].id
  vpc_security_group_ids = [aws_security_group.imad_sg.id]

  tags = {
    Name = "imad-ec2-instance"
  }
}



# Créer un Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.imad_vpc.id
}

# Créer une NAT Gateway
resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.imad_public_subnet[0].id # Choisir le premier sous-réseau public
}

# Créer des tables de routage

# Table de routage pour les sous-réseaux publics
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.imad_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

resource "aws_route_table_association" "public" {
  count          = 3 # Pour chaque sous-réseau public
  subnet_id      = aws_subnet.imad_public_subnet[count.index].id
  route_table_id = aws_route_table.public.id
}

# Table de routage pour les sous-réseaux privés
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.imad_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "Private Route Table"
  }
}

resource "aws_route_table_association" "private" {
  count          = 3 # Pour chaque sous-réseau privé
  subnet_id      = aws_subnet.imad_private_subnet[count.index].id
  route_table_id = aws_route_table.private.id
}
