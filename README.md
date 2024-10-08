Dossiers Terraform Pour creer des EKS et node avec addon 

- VPC créé

- 3 subnets publics et privés créés

- Une instance EC2 Amazon Linux 2023 de type t2.micro créée

- Un security group autorisant la connexion SSH, HTTP et HTTPS (toutes IPs)

- Un cluster EKS en node group (EC2 managées par l'utilisateur et de type t2.micro)

- Les addons VPC-CNI, CoreDNS, et kube-proxy devront être obligatoirement installés sur le cluster

- Le rôle IAM qui devra être associé à EKS sera le rôle EKS_Students, déjà présent sur la plateforme 
AWS 

- Un load balancer applicati

Issue de TP de Kevin CHEVREUIL
