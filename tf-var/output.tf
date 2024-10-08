output "eks_cluster_name" {
  description = "Nom du cluster EKS"
  value       = aws_eks_cluster.imad_cluster.name
}

output "eks_cluster_endpoint" {
  description = "Adresse pour accéder à l'API Kubernetes du cluster"
  value       = aws_eks_cluster.imad_cluster.endpoint
}

output "eks_cluster_version" {
  description = "Version de Kubernetes du cluster"
  value       = aws_eks_cluster.imad_cluster.version
}

output "node_group_name" {
  description = "Nom du groupe de machines EKS"
  value       = aws_eks_node_group.imad_node_group.node_group_name
}

output "alb_dns_name" {
  description = "Nom DNS de ton Load Balancer"
  value       = aws_lb.imad_alb.dns_name
}

output "ec2_instance_public_ip" {
  description = "Adresse IP publique de la machine EC2"
  value       = aws_instance.web.public_ip
}

output "subnet_pub1_id" {
  description = "ID du premier sous-réseau public"
  value       = aws_subnet.subnet_pub1.id
}

output "subnet_prv1_id" {
  description = "ID du premier sous-réseau privé"
  value       = aws_subnet.subnet_prv1.id
}

output "vpc_id" {
  description = "ID de la VPC"
  value       = aws_vpc.imad_vpc.id
}
