resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  security_groups   = ["${aws_security_group.web-ssh-http.name}"]
  user_data = <<-EOF
                #! /bin/bash
                sudo apt install apache2 -y
                sudo ufw allow 'Apache'
                sudo systemctl start httpd
                sudo systemctl enable httpd
                sudo echo "<h1>Startseite - Pascal Werren" | sudo tee var/www/html/index.html
  EOF

  tags = {
    Name                 = data.external.resouce_name.result.name
    "Linux Distribution" = "Ubuntu"
  }

}
resource "aws_security_group" "web-ssh-http" {
  name = "web-ssh-http"
  description = "allow ssh and http traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_ebs_volume" "web-storage" {
  availability_zone = var.region
  size              = 1
  tags              = {
    Name = "webstorage"
  }
}

resource "aws_volume_attachment" "web-storage-attach"{
  device_name   = "/dev/sdd"
  volume_id     = "${aws_ebs_volume.web-storage.id}"
  instance_id   = "${aws_instance.web.id}"
}