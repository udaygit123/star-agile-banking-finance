provider "aws"{
 region = "us-east-1"
 access_key= "AKIAYOY47DPG2J3LFR5W"
 secret_key= "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"
}
description = "Allow inbound traffic"
vpc_id = aws_vpc.myvpc1.id
ingress {
description = "HTTP"
from_port = 80
to_port = 80
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}
ingress {
description = "SSH"
from_port = 22
to_port = 22
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}
egress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
ipv6_cidr_blocks = ["::/0"]
}
tags = {
Name = "mysg1"
}
}

resource "aws_network_interface" "web-server-nic" {
 subnet_id = aws_subnet.mysubnet1.id
 private_ips = ["10.0.1.50"]
 security_groups = [aws_security_group.mysg1.id]
}
resource "aws_instance" "web" {
 ami = "ami-0f8ca728008ff5af4"
 instance_type = "t2.micro"
 key_name = "jenkinskey1"
 tags = {
 Name = "terraforminst"
 }
}
resource "aws_eip_association" "eip_assoc" {
 instance_id = aws_instance.web.id
 allocation_id = aws_eip.example.id
}
resource "aws_eip" "example" {
 vpc = true
}

