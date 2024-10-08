resource "aws_instance" "web" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.subnet_pub1.id
  vpc_security_group_ids = [aws_security_group.imad_sg.id]
  tags = {
    Name = "imad-EC2"
  }
}
