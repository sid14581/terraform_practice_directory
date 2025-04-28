resource "aws_instance" "server" {
  ami                    = "ami-04f167a56786e4b09"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.provision_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.provision_sgp.id]
  subnet_id              = aws_subnet.provision_sub1.id

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("C:\\Users\\<user>\\.ssh\\id_ed25519")
    host        = self.public_ip
    timeout = "2m"
  }


  provisioner "file" {
    source      = "app.py"
    destination = "/home/ubuntu/app.py"
  }

  provisioner "remote-exec" {
    inline = [
        "echo 'Hello from the remote instance'",
        "sudo apt update -y",
        "cd /home/ubuntu/",
        "sudo apt install -y python3-flask",
        "sudo python3 /home/ubuntu/app.py &"
    ]
  }
   depends_on = [aws_key_pair.provision_key_pair]
}
