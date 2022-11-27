resource "aws_instance" "weppy" {
  ami = var.ami_id
  instance_type = var.server

  tags = {
    Name = "airbnb-wepserver"
  }
}