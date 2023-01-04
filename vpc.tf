
#VPC----------------------

resource "aws_vpc" "dev" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "dev-VPC"
  }
}

# Subnet---------------

resource "aws_subnet" "dev_public-1" {
  vpc_id            = aws_vpc.dev.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.availability_zone1
  tags = {
    "name" = "publuc_subnet-1"
  }
}

resource "aws_subnet" "dev-public-2" {
  vpc_id            = aws_vpc.dev.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = var.availability_zone2
    tags = {
    "name" = "publuc_subnet-2"
  }
}


#Internet gateway terraform--------------

resource "aws_internet_gateway" "dev-gw" {
  vpc_id = aws_vpc.dev.id
}

#Route Table--------------------------

resource "aws_route_table" "dev-route" {
  vpc_id = aws_vpc.dev.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev-gw.id
  }

  tags = {
    Name = "route"
  }
}

#Route table association--------------

resource "aws_route_table_association" "dev-public-1-a" {
  subnet_id      = aws_subnet.dev_public-1.id
  route_table_id = aws_route_table.dev-route.id
}

resource "aws_route_table_association" "dev-public-2-b" {
  subnet_id      = aws_subnet.dev-public-2.id
  route_table_id = aws_route_table.dev-route.id
}


