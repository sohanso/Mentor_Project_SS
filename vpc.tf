## VPC ##
resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}
## Public Subnet 1 ##
resource "aws_subnet" "public_1" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = var.cidr_public_1
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet_1"
  }
}
## Private Subnet 1 ##
resource "aws_subnet" "private_1" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = var.cidr_private_1
  tags = {
    Name = "private_subnet_1"
  }
}
## Internet Gateway ##
resource "aws_internet_gateway" "main_igw" {
    vpc_id = aws_vpc.main_vpc.id
    tags = {
        Name = "Internet gateway"
        Id = "Mentor_Project"
    }
}
resource "aws_route" "route_igw" {
  route_table_id            = var.rtb_public_id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.main_igw.id
}
