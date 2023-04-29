#------------------------
# Worker Node
#------------

resource "aws_eks_node_group" "example" {
  cluster_name    = ${var.eks_cluster}
  node_group_name = "eksnodegroup"
  node_role_arn   = aws_iam_role.eksnoderole.arn
  subnet_ids      = ${var.subnet_id}

  scaling_config {
    desired_size = 2
    max_size     = 4
    min_size     = 2
  }

  update_config {
    max_unavailable = 2
  }

  depends_on = [
    aws_iam_role_policy_attachment.eksnode-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eksnode-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eksnode-AmazonEC2ContainerRegistryReadOnly,
  ]
}