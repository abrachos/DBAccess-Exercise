data "aws_iam_role" "github_action_role" {
  name = "githubactiontoaws"
}

resource "aws_iam_role_policy_attachment" "github_action_role_AmazonEKSClusterPolicy" {
  role       = data.aws_iam_role.github_action_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "github_action_role_AmazonEKSWorkerNodePolicy" {
  role       = data.aws_iam_role.github_action_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "github_action_role_AmazonEC2ContainerRegistryReadOnly" {
  role       = data.aws_iam_role.github_action_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "kubernetes_cluster_role" "eks_role" {
  metadata {
    name = "github-actions-role"
  }

  rule {
    api_groups = [""]
    resources  = ["nodes", "pods", "services"]
    verbs      = ["get", "list", "watch"]
  }
}

resource "kubernetes_cluster_role_binding" "eks_rolebinding" {
  metadata {
    name = "github-actions-rolebinding"
  }

  subject {
    kind      = "User"
    name      = "arn:aws:eks:us-east-2:509399606070:cluster/virtualaccount-cluster"
    api_group = "rbac.authorization.k8s.io"
  }

  role_ref {
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.eks_role.metadata[0].name
    api_group = "rbac.authorization.k8s.io"
  }
}
