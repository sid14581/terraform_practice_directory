resource "aws_key_pair" "provision_key_pair" {
  key_name   = var.key_name
  public_key = file("C:\\Users\\<user>\\.ssh\\id_ed25519.pub")
}