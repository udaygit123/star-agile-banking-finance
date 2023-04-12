resource "aws_instance" "test-server" {
  ami           = "ami-007855ac798b5175e" 
  instance_type = "t2.micro" 
  key_name = "jenkinskey1"
  //vpc_security_group_id= ["sg-0cb6a83c3d85f7462"]
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
