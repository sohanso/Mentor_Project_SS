
packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

source "amazon-ebs" "ubuntu_instance" {
  ami_name          = "ubuntu-ansi-docker-${local.timestamp}"
  instance_type     = "t3.small"
  region            = "ap-south-1"
  ssh_username      = "ubuntu"
  vpc_id            = "vpc-033f3248f9dab725c"
  subnet_id         = "subnet-0e056fe7fac71b152"
  security_group_id = "sg-0162ac9e0f1dd9374"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  tags = {
    "Name" = "AMI with ansible docker"
    "Id"   = "Mentor_Project"
  }
}

build {
  name = "ubuntu-ansi-docker-run"
  sources = [
    "source.amazon-ebs.ubuntu_instance",
  ]
}

