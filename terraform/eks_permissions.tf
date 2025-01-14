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
