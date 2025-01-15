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

resource "kubernetes_role" "eks_role" {
  metadata {
    name      = "eks-role"
    namespace = "default"
  }

  rule {
    api_groups = [""]
    resources  = ["nodes", "pods", "services"]
    verbs      = ["get", "list", "watch"]
  }

  lifecycle {
    ignore_changes = [
      metadata[0].annotations["kubectl.kubernetes.io/last-applied-configuration"]
    ]
  }
}

resource "kubernetes_role_binding" "eks_rolebinding" {
  metadata {
    name      = "eks-rolebinding"
    namespace = "default"
  }

  subject {
    kind      = "User"
    name      = "arn:aws:sts::509399606070:assumed-role/githubactiontoaws/GitHubActions"
    api_group = "rbac.authorization.k8s.io"
  }

  role_ref {
    kind      = "Role"
    name      = kubernetes_role.eks_role.metadata[0].name
    api_group = "rbac.authorization.k8s.io"
  }
}