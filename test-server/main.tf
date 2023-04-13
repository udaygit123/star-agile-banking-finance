resource "aws_instance" "test-server" {
  ami           = "ami-0fcf52bcf5db7b003" 
  instance_type = "t2.micro" 
  key_name = "jenkinskey1"
  subnet_id = "subnet-0d92bb9a83034e304"
  vpc_security_group_ids = ["sg-0064e5f6f15377494"]
 
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
