resource "aws_instance" "weppy" {
  ami = var.ami_id
  instance_type = var.server
  monitoring = true
  ebs_optimized = true
  tags = {
    Name = "airbnb-wepserver"
  }
}