data "aws_iam_role" "github_action_role" {
  name = "githubactiontoaws"
}

resource "aws_iam_role_policy_attachment" "github_action_role_AmazonEKSAdminPolicy" {
  role       = data.aws_iam_role.github_action_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSAdminPolicy"
}

resource "aws_iam_role_policy_attachment" "github_action_role_AmazonEKSClusterAdminPolicy" {
  role       = data.aws_iam_role.github_action_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}
