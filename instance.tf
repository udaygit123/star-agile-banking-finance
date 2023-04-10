resource "aws_instance" "production-server" {
 ami = "ami-085d2183d3c2e3576"
 instance_type = "t2.micro"
 availability_zone = ap-northeast-3""
 vpc_security_group_ids = ["sg-07d188f0228f6cce5"]
 key_name = "jenkinskey1"
 tags = {
 name = "ansible_instance"
 }
 provisioner "remote-exec" {
 inline = [
     "ansible-playbook bankdeployplaybook.yml"
     ]
     }
     }
