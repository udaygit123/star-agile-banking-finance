resource "aws_instance" "test-server" {
  ami           = "ami-02eb7a4783e7e9317" 
  instance_type = "t2.medium" 
  key_name = "jenkinskey1.pem"
  subnet_id = "subnet-071971b3fdc4215d4"
  vpc_security_group_ids = ["sg-08f2b02ee2fe9d1c7"]
 
  connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = file("./jenkinskey1.pem")
    host     = self.public_ip
  }
  provisioner "remote-exec" {
    inline = [ "echo 'wait to start instance' "]
  }
  tags = {
    Name = "test-server"
  }
  provisioner "local-exec" {
        command = " echo ${aws_instance.test-server.public_ip} > inventory "
  }
   provisioner "local-exec" {
  command = "ansible-playbook /var/lib/jenkins/workspace/Bankingproject/test-server/finance-playbook.yml "
  } 
}
