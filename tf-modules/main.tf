#provider "aws" {
# region = var.aws_region
#}

module "core_compute" {
  source                = "./modules/core-compute"
  aws_region            = "us-west-1"
  vpc_cidr              = "10.0.0.0/16"
  public_subnets_cidrs  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets_cidrs = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

# Configuration supplémentaire pour le cluster EKS



resource "aws_eks_cluster" "eks_cluster" {
  name     = "imad-eks-cluster"
  role_arn = "arn:aws:iam::268849317545:role/EKS_Students"

  vpc_config {
    subnet_ids = module.core_compute.private_subnets_ids
  }

  depends_on = [module.core_compute]
}

resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "imad-node-group"
  node_role_arn   = "arn:aws:iam::268849317545:role/EKS_Students"

  subnet_ids = [
    module.core_compute.public_subnets_ids[0], # Subnet dans AZ 1
    module.core_compute.public_subnets_ids[2], # Subnet dans AZ 2
  ]
  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  instance_types = ["t2.micro"]

  depends_on = [aws_eks_cluster.eks_cluster]
}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name = aws_eks_cluster.eks_cluster.name
  addon_name   = "vpc-cni"
}

resource "aws_eks_addon" "coredns" {
  cluster_name = aws_eks_cluster.eks_cluster.name
  addon_name   = "coredns"
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name = aws_eks_cluster.eks_cluster.name
  addon_name   = "kube-proxy"
}

resource "aws_lb" "application_lb" {
  name               = "imad-app-lb"
  load_balancer_type = "application"
  subnets = [
    module.core_compute.public_subnets_ids[0], # Subnet dans AZ 1
    module.core_compute.public_subnets_ids[2], # Subnet dans AZ 2
  ]

  security_groups = [module.core_compute.sg]
  tags = {
    Name = "imad-app-lb"
  }
}

data "aws_caller_identity" "current" {}

