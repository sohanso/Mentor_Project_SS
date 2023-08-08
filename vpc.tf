## Default VPC for packer##
resource "aws_default_vpc" "def_vpc" {
  tags = {
    Name = "Main-Default-VPC"
  }
}

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
    Name = "main_vpc_public_subnet_1"
  }
}
## Private Subnet 1 ##
resource "aws_subnet" "private_1" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = var.cidr_private_1
  tags = {
    Name = "main_vpc_private_subnet_1"
  }
}
## Internet Gateway ##
resource "aws_internet_gateway" "main_igw" {
    vpc_id = aws_vpc.main_vpc.id
    tags = {
        Name = "Main_vpc_Internet_gateway"
        Id = "Mentor_Project"
    }
}

## ROute table for Public subnet with IGW route ##
resource "aws_route_table" "public_1_rtb" {
    vpc_id = aws_vpc.main_vpc.id
    tags = {
        Name = "public_1_route_table"
        Id = "Mentor_Project"
    } 
}
resource "aws_route" "public_1_route" {
  route_table_id            = aws_route_table.public_1_rtb.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.main_igw.id
}

resource "aws_route_table_association" "public_1_assoc" {
  subnet_id = aws_subnet.public_1.id
  route_table_id = aws_route_table.public_1_rtb.id 
}


resource "aws_security_group" "default_sg" {
    name = "default-sg-22-80"
    description = "Allow 22 and 80"
    vpc_id = aws_default_vpc.def_vpc.id

    ingress {
        description = "allow port 22"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "allow port 22"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
      "Name" = "default-sg-22-80"
    }
}