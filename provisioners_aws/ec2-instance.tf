resource "aws_instance" "server" {
  ami                    = "ami-0261755bbcb8c4a84"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.provision_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.webSg.id]
  subnet_id              = aws_subnet.provision_sub1.id

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("C:\\Users\\<username>\\.ssh\\id_ed25519.pub")
    host        = self.public_ip
  }

  
  provisioner "file" {
    source      = "app.py"
    destination = "/home/ubuntu/app.py"
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Hello from the remote instance'",
      "sudo apt update -y",
      "sudo apt-get install -y python3-pip",
      "cd /home/ubuntu",
      "sudo pip3 install flask",
      "sudo python3 app.py &",
    ]
  }
}