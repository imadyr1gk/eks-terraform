variable "region" {
  description = "AWS region"
  #default     = "us-west-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnets_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "private_subnets_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "eks_cluster_name" {
  description = "Name of the EKS cluster"
  default     = "imad-cluster"
}

variable "node_group_name" {
  description = "Name of the EKS node group"
  default     = "eks_nodes"
}

variable "desired_size" {
  description = "Desired number of nodes in the EKS node group"
  #  default     = 2
}

variable "max_size" {
  description = "Maximum number of nodes in the EKS node group"
  # default     = 3
}

variable "min_size" {
  description = "Minimum number of nodes in the EKS node group"
  default     = 1
}

