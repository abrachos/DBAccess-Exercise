data "aws_iam_user" "github_action_user" {
  user_name = "githubaction_aws"  # Reemplaza con el nombre del usuario IAM
}

resource "aws_eks_access_entry" "github_action_user" {
  cluster_name  = "virtualaccount-cluster"  # Reemplaza con el nombre de tu clúster EKS
  principal_arn = "arn:aws:iam::509399606070:user/githubaction_aws"  # ARN del usuario proporcionado
  type          = "STANDARD"
}

resource "aws_eks_access_policy_association" "github_action_user_AmazonEKSAdminPolicy" {
  cluster_name  = "virtualaccount-cluster"  # Reemplaza con el nombre de tu clúster EKS
  policy_arn    = "arn:aws:iam::aws:policy/AmazonEKSAdminPolicy"
  principal_arn = aws_eks_access_entry.github_action_user.principal_arn

  access_scope {
    type = "cluster"
  }
}

resource "aws_eks_access_policy_association" "github_action_user_AmazonEKSClusterAdminPolicy" {
  cluster_name  = "virtualaccount-cluster"  # Reemplaza con el nombre de tu clúster EKS
  policy_arn    = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  principal_arn = aws_eks_access_entry.github_action_user.principal_arn

  access_scope {
    type = "cluster"
  }
}
