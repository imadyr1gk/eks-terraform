resource "aws_eks_cluster" "imad_cluster" {
  name     = "imad-cluster"
  role_arn = "arn:aws:iam::268849317545:role/EKS_Students"
  vpc_config {
    subnet_ids = [
      aws_subnet.subnet_pub1.id,
      aws_subnet.subnet_pub2.id,
      aws_subnet.subnet_pub3.id
    ]
  }
}

resource "aws_eks_node_group" "imad_node_group" {
  cluster_name    = aws_eks_cluster.imad_cluster.name
  node_group_name = "eks_nodes"
  node_role_arn   = data.aws_iam_role.eks_student_role.arn
  subnet_ids = [
    aws_subnet.subnet_prv1.id,
    aws_subnet.subnet_prv2.id,
    aws_subnet.subnet_prv3.id
  ]

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  instance_types = ["t2.micro"]
}

# Addons
resource "aws_eks_addon" "coredns" {
  cluster_name             = aws_eks_cluster.imad_cluster.name
  addon_name               = "coredns"
  service_account_role_arn = "arn:aws:iam::268849317545:role/EKS_Students"
  depends_on               = [aws_eks_cluster.imad_cluster]
}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name             = aws_eks_cluster.imad_cluster.name
  addon_name               = "vpc-cni"
  service_account_role_arn = "arn:aws:iam::268849317545:role/EKS_Students"
  depends_on               = [aws_eks_cluster.imad_cluster]

}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name             = aws_eks_cluster.imad_cluster.name
  addon_name               = "kube-proxy"
  service_account_role_arn = "arn:aws:iam::268849317545:role/EKS_Students"
  depends_on               = [aws_eks_cluster.imad_cluster]
}

