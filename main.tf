provider "aws" {
  region = var.region
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "ubuntu" {
  count         = var.instances_count
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  //memory        = var.instance_mem * 1024
  //num_cpus      = var.instance_cpu

  tags = {
    Name                 = var.instance_hostname_prefix
    "Linux Distribution" = "Ubuntu"
  }
  
  owners = ["099720109477"] # Canonical
}
