resource "aws_instance" "production-server" {
 ami = "ami-007855ac798b5175e"
 instance_type = "t2.micro"
 availability_zone = "us-east-1a"
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
