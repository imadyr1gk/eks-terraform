data "aws_availability_zones" "available" {
  state = "available"
}

#data source pour ec2 t2.micro
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] #CanonicalUbuntuOwnerEnterpriseUbuntuOwnerEnterprise
}

#data eks student role
data "aws_iam_role" "eks_student_role" {
  name = "EKS_Students" # Nom du rôle IAM que tu veux récupérer
}

