resource "aws_instance" "production-server" {
 ami = "ami-0a5dcff6fb7af3fc9"
 instance_type = "t2.micro"
 availability_zone = "ap-south-1"
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
