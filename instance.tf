resource "aws_instance" "soweb1" {
  ami           = data.aws_ami.ami_with_ansi_dock.id
  instance_type = "t3.medium"
  security_groups = [aws_security_group.ubuntu_server_sg.id]
  key_name = "mumbai_1"
  subnet_id = aws_subnet.public_1.id
  user_data = filebase64("jenkins.sh")

  tags = {
    "Name" = "so_web1"
  }
}


resource "aws_security_group" "ubuntu_server_sg" {
    name = "ubuntu_server_sg"
    description = "Allow connection for ubuntu server"
    vpc_id = aws_vpc.main_vpc.id

    ingress {
        description = "allow port 22"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "allow port 8080"
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "allow port 8081"
        from_port = 8081
        to_port = 8081
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "allow port 80"
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
      "Name" = "ubuntu_server_sg"
    }
}





