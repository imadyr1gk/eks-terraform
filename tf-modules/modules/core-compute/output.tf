output "vpc_id" {
  value = aws_vpc.imad_vpc.id
}

output "public_subnets_ids" {
  value = aws_subnet.imad_public_subnet[*].id
}

output "private_subnets_ids" {
  value = aws_subnet.imad_private_subnet[*].id
}

output "ec2_instance_public_ip" {
  value = aws_instance.imad_ec2_instance.public_ip
}


output "sg" {
  value = aws_security_group.imad_sg.id
}

