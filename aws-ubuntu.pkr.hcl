packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = "~> 1"
    }
  }
}

variable "vpc_id_default" {
    description = "default vpc id"  
    default = "vpc-08c328b418345d090"
}
locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

source "amazon-ebs" "ubuntu_instance" {
  ami_name      = "ubuntu-ansi-docker-${local.timestamp}"
  instance_type = "t3.medium"
  region        = "ap-south-1"
  ssh_username  = "ubuntu"
  vpc_id        = "${var.vpc_id_default}"
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
    "source.amazon-ebs.ubuntu_instance"
  ]
  provisioner "shell" {
    inline = [
      "sudo apt -y update",
      "sudo apt-get install -y software-properties-common",
      "sudo apt-add-repository -y ppa:ansible/ansible",
      "sudo apt-get install -y ansible"
    ]
  }
  provisioner "shell" {
    inline = [
      "sudo apt install -y apt-transport-https ca-certificates curl software-properties-common",
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg",
      "echo 'deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable' | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
      "sudo apt install -y docker-ce",
      "sudo systemctl start docker",
      "sudo systemctl enable docker"
    ]
  }
}

