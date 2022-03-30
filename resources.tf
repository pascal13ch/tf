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

  owners = ["099720109477"] # Canonical

}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  tags = {
    Name                 = data.external.resouce_name.result.name
    "Linux Distribution" = "Ubuntu"
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file("${path.module}/aws_key")
    timeout     = "4m"
  }

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "apt update",
      "apt -y install apache2"
    ]
  }
}


resource "aws_key_pair" "deployer" {
  key_name   = "aws_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDak9DLleCQOyn1RtehV5M2B2SrTi1Yfus+MJ1mmuy8rDHWjavfpgZYpwP58iELPqIinhK7HGsgcWhyTJ38wJzZlyMT6CkFL3zo1HSyRGJp8VrE63IAK/lU+JSFHASxEI1WtBAXEKo58xUoO5IvyD44kBGucHVZueKU7e3HzdYHCqf8Jk9eWkkaRoqD3mMZj4j3seyIrO7foEYjqUp1L4YIBUVWWGXX/j1e9fhVgNsfchIDWLsiGHDzuIvQtaz6EdVVqpe6aijOG12hWU6j3WzeFrHdakjVa/Pg2AZG337bFV8GgxVGCbsTPhmK1G6QTO7IFxqO7V4T1hG/p3Owd0k5 post\\werrenp@w00vlq"
}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
  ingress                = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 22
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 22
    }
  ]
}