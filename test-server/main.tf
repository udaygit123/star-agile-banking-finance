resource "aws_instance" "test-server1" {
  ami           = "ami-0aa2b7722dc1b5612" 
  instance_type = "t2.micro" 
  key_name = "JenkinSerP1key"
  vpc_security_group_ids= ["sg-077ce7b1c53c11b8a"]
  
  connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = file("./JenkinSerP1key.pem")
    host     = self.public_ip
  }
  provisioner "remote-exec" {
    inline = [ "echo 'wait to start instance' "]
  }
  tags = {
    Name = "test-server1"
  }
  provisioner "local-exec" {
        command = " echo ${aws_instance.test-server1.public_ip} > inventory "
  }
   provisioner "local-exec" {
  command = "ansiblePlaybook credentialsId: 'ubuntu', disableHostKeyChecking: true, installation: 'ansible', inventory: '/etc/ansible/hosts', playbook: '/var/lib/jenkins/workspace/Banking-F-Project/test-server/myansible-playbook.yml'"
  } 
}
