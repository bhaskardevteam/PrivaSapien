provider "aws" {
  region = "your-region"
}

resource "aws_eks_cluster" "eks_cluster" {
  name     = "eks-cluster"
  role_arn = "arn:aws:iam::your-account-id:role/eks-cluster-role"

  vpc_config {
    subnet_ids         = ["subnet-xxxxxx", "subnet-yyyyyy"]
    security_group_ids = ["sg-xxxxxx"]
resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "eks-node-group"
  node_role_arn   = "arn:aws:iam::your-account-id:role/eks-node-role"

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 2
  }

  launch_template {
    id      = ""
    version = "$Latest"
    name    = "eks-node-launch-template"
    description = "Launch template for EKS worker nodes"
    instance_type = "t2.micro"
    key_name = "your-key-pair-name"
    security_group_ids = [""]
    iam_instance_profile {
      name = "your-instance-profile-name"
    }
    block_device_mappings {
      device_name = "/dev"
      ebs {
        volume_size = 20
        delete_on_termination = true
        volume_type = "gp2"
      }
    }
    tag_specifications {
      resource_type = "instance"
      tags = {
        Name = "eks-node"
        Environment = "production"
      }
    }
  }
}

